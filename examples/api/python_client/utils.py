import logging
import os
import yaml
from typing import Any, Dict

def setup_logging(level: str = "INFO"):
    logging.basicConfig(
        level=getattr(logging, level.upper()),
        format='%(asctime)s %(levelname)s %(name)s: %(message)s'
    )


def get_env_variable(name: str, default: str = "") -> str:
    return os.getenv(name, default)


def load_kubeconfig(path: str = None) -> Dict[str, Any]:
    """Load kubeconfig YAML as a dict."""
    if not path:
        path = os.path.expanduser("~/.kube/config")
    with open(path, 'r') as f:
        return yaml.safe_load(f)


def save_kubeconfig(config: Dict[str, Any], path: str = None):
    """Save kubeconfig dict as YAML."""
    if not path:
        path = os.path.expanduser("~/.kube/config")
    with open(path, 'w') as f:
        yaml.safe_dump(config, f, default_flow_style=False)


def set_runai_api_user_token(token: str, kubeconfig_path: str = None):
    """
    Set or update the 'runai-api' user in kubeconfig with the given token.
    """
    config = load_kubeconfig(kubeconfig_path)
    users = config.get('users', [])
    user_found = False
    for user in users:
        if user.get('name') == 'runai-api':
            user['user'] = {'token': token}
            user_found = True
            break
    if not user_found:
        users.append({'name': 'runai-api', 'user': {'token': token}})
    config['users'] = users
    save_kubeconfig(config, kubeconfig_path) 