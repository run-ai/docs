package kubeconfig

import (
	"fmt"
	"os"
	"path/filepath"

	kubeconfig "github.com/siderolabs/go-kubeconfig"
	"k8s.io/client-go/tools/clientcmd/api"
)

// SetRunAIAPIUserToken sets or updates the runai-api user token in the kubeconfig
func SetRunAIAPIUserToken(token, path string) error {
	if path == "" {
		homeDir, err := os.UserHomeDir()
		if err != nil {
			return fmt.Errorf("failed to get user home directory: %w", err)
		}
		path = filepath.Join(homeDir, ".kube", "config")
	}

	// Load the kubeconfig
	merger, err := kubeconfig.Load(path)
	if err != nil {
		return fmt.Errorf("failed to load kubeconfig: %w", err)
	}

	// Convert merger to clientcmdapi.Config to access Users
	config := (*api.Config)(merger)

	// Ensure Users map exists
	if config.AuthInfos == nil {
		config.AuthInfos = make(map[string]*api.AuthInfo)
	}

	// Set or update the runai-api user with the token
	config.AuthInfos["runai-api"] = &api.AuthInfo{
		Token: token,
	}

	// Save the kubeconfig
	if err := merger.Write(path); err != nil {
		return fmt.Errorf("failed to save kubeconfig: %w", err)
	}

	return nil
}
