import os
import time
import logging
import requests
from typing import Optional, Any, Dict
from runai_python_client.utils import set_runai_api_user_token

class RunAIClient:
    """
    Client for interacting with the Run:AI API using client credentials.
    Handles authentication, token refresh, API calls, and kubeconfig updates.
    """
    def __init__(self, client_id: str, client_secret: str, base_url: str = "https://api.run.ai", kubeconfig_path: Optional[str] = None):
        self.client_id = client_id
        self.client_secret = client_secret
        self.base_url = base_url.rstrip("/")
        self.token_url = f"{self.base_url}/api/v1/token"
        self.workloads_url = f"{self.base_url}/api/v1/workloads"
        self.token: Optional[str] = None
        self.token_expires_at: float = 0
        self.session = requests.Session()
        self.logger = logging.getLogger("RunAIClient")
        self.kubeconfig_path = kubeconfig_path

    def authenticate(self) -> None:
        """
        Authenticate with the Run:AI API and store the access token.
        Also update kubeconfig if enabled.
        """
        data = {
            "grantType": "client_credentials",
            "clientId": self.client_id,
            "clientSecret": self.client_secret
        }
        response = self.session.post(self.token_url, json=data)
        if response.status_code == 200:
            token_data = response.json()
            self.token = token_data["accessToken"]
            self.token_expires_at = time.time() + token_data.get("expiresIn", 3600) - 60
            self.logger.info("Obtained new token.")
            if self.kubeconfig_path is not None:
                set_runai_api_user_token(self.token, self.kubeconfig_path)
                self.logger.info(f"Updated kubeconfig at {self.kubeconfig_path} with new token.")
        else:
            self.logger.error(f"Failed to obtain token: {response.status_code} {response.text}")
            raise Exception("Authentication failed")

    def ensure_token(self) -> None:
        """
        Ensure the access token is valid, refreshing if necessary.
        """
        if not self.token or time.time() > self.token_expires_at:
            self.logger.info("Token expired or missing, authenticating...")
            self.authenticate()

    def get_workloads(self) -> Optional[Any]:
        """
        Fetch workloads from the Run:AI API. Refresh token on 401.
        Returns the workloads list or None on failure.
        Also updates kubeconfig if token is refreshed.
        """
        self.ensure_token()
        headers = {"Authorization": f"Bearer {self.token}"}
        response = self.session.get(self.workloads_url, headers=headers)
        if response.status_code == 401:
            self.logger.warning("Token expired or invalid, re-authenticating...")
            self.authenticate()
            headers = {"Authorization": f"Bearer {self.token}"}
            response = self.session.get(self.workloads_url, headers=headers)
        if response.status_code == 200:
            self.logger.info("Successfully fetched workloads.")
            return response.json().get("workloads", [])
        else:
            self.logger.error(f"Failed to fetch workloads: {response.status_code} {response.text}")
            return None 