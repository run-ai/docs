package client

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"runai_go_client/pkg/kubeconfig"

	"github.com/sirupsen/logrus"
)

// TokenRequest represents the request payload for authentication
type TokenRequest struct {
	GrantType    string `json:"grantType"`
	ClientID     string `json:"clientId"`
	ClientSecret string `json:"clientSecret"`
}

// TokenResponse represents the response from the token endpoint
type TokenResponse struct {
	AccessToken string `json:"accessToken"`
	ExpiresIn   int    `json:"expiresIn"`
}

// WorkloadsResponse represents the response from the workloads endpoint
type WorkloadsResponse struct {
	Workloads []map[string]interface{} `json:"workloads"`
}

// RunAIClient handles authentication and API calls to Run:AI
type RunAIClient struct {
	ClientID       string
	ClientSecret   string
	BaseURL        string
	TokenURL       string
	WorkloadsURL   string
	Token          string
	TokenExpiresAt time.Time
	HTTPClient     *http.Client
	Logger         *logrus.Logger
	KubeconfigPath string
}

// NewRunAIClient creates a new RunAI client instance
func NewRunAIClient(clientID, clientSecret, baseURL string, kubeconfigPath string) *RunAIClient {
	if baseURL == "" {
		baseURL = "https://api.run.ai"
	}

	logger := logrus.New()
	logger.SetFormatter(&logrus.TextFormatter{
		FullTimestamp: true,
	})

	return &RunAIClient{
		ClientID:       clientID,
		ClientSecret:   clientSecret,
		BaseURL:        baseURL,
		TokenURL:       fmt.Sprintf("%s/api/v1/token", baseURL),
		WorkloadsURL:   fmt.Sprintf("%s/api/v1/workloads", baseURL),
		HTTPClient:     &http.Client{Timeout: 30 * time.Second},
		Logger:         logger,
		KubeconfigPath: kubeconfigPath,
	}
}

// Authenticate obtains a new access token from the Run:AI API
func (c *RunAIClient) Authenticate() error {
	tokenReq := TokenRequest{
		GrantType:    "client_credentials",
		ClientID:     c.ClientID,
		ClientSecret: c.ClientSecret,
	}

	jsonData, err := json.Marshal(tokenReq)
	if err != nil {
		return fmt.Errorf("failed to marshal token request: %w", err)
	}

	req, err := http.NewRequest("POST", c.TokenURL, bytes.NewBuffer(jsonData))
	if err != nil {
		return fmt.Errorf("failed to create token request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")

	resp, err := c.HTTPClient.Do(req)
	if err != nil {
		return fmt.Errorf("failed to send token request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("token request failed with status %d: %s", resp.StatusCode, string(body))
	}

	var tokenResp TokenResponse
	if err := json.NewDecoder(resp.Body).Decode(&tokenResp); err != nil {
		return fmt.Errorf("failed to decode token response: %w", err)
	}

	c.Token = tokenResp.AccessToken
	c.TokenExpiresAt = time.Now().Add(time.Duration(tokenResp.ExpiresIn-60) * time.Second) // refresh 1 min early
	c.Logger.Info("Obtained new token")

	// Update kubeconfig if path is provided
	if c.KubeconfigPath != "" {
		if err := kubeconfig.SetRunAIAPIUserToken(c.Token, c.KubeconfigPath); err != nil {
			c.Logger.WithError(err).Warn("Failed to update kubeconfig")
		} else {
			c.Logger.Infof("Updated kubeconfig at %s with new token", c.KubeconfigPath)
		}
	}

	return nil
}

// EnsureToken ensures the access token is valid, refreshing if necessary
func (c *RunAIClient) EnsureToken() error {
	if c.Token == "" || time.Now().After(c.TokenExpiresAt) {
		c.Logger.Info("Token expired or missing, authenticating...")
		return c.Authenticate()
	}
	return nil
}

// GetWorkloads fetches workloads from the Run:AI API
func (c *RunAIClient) GetWorkloads() ([]map[string]interface{}, error) {
	if err := c.EnsureToken(); err != nil {
		return nil, err
	}

	req, err := http.NewRequest("GET", c.WorkloadsURL, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create workloads request: %w", err)
	}
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", c.Token))

	resp, err := c.HTTPClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send workloads request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode == http.StatusUnauthorized {
		c.Logger.Warn("Token expired or invalid, re-authenticating...")
		if err := c.Authenticate(); err != nil {
			return nil, err
		}
		// Retry with new token
		req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", c.Token))
		resp, err = c.HTTPClient.Do(req)
		if err != nil {
			return nil, fmt.Errorf("failed to retry workloads request: %w", err)
		}
		defer resp.Body.Close()
	}

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return nil, fmt.Errorf("workloads request failed with status %d: %s", resp.StatusCode, string(body))
	}

	var workloadsResp WorkloadsResponse
	if err := json.NewDecoder(resp.Body).Decode(&workloadsResp); err != nil {
		return nil, fmt.Errorf("failed to decode workloads response: %w", err)
	}

	c.Logger.Info("Successfully fetched workloads")
	return workloadsResp.Workloads, nil
}

// SetLogLevel sets the logging level
func (c *RunAIClient) SetLogLevel(level logrus.Level) {
	c.Logger.SetLevel(level)
}
