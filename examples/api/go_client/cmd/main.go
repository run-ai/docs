package main

import (
	"encoding/json"
	"fmt"
	"os"
	"time"

	"runai_go_client/pkg/client"

	"github.com/joho/godotenv"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var (
	clientID       string
	clientSecret   string
	baseURL        string
	interval       int
	logLevel       string
	kubeconfigPath string
)

var rootCmd = &cobra.Command{
	Use:   "runai-go-client",
	Short: "Run:AI API Client - Periodically fetch workloads",
	Long:  `A professional Go client for the Run:AI API that authenticates using client credentials and periodically fetches workloads.`,
	Run:   runClient,
}

func init() {
	// Load .env file if it exists
	_ = godotenv.Load()

	rootCmd.Flags().StringVar(&clientID, "client-id", os.Getenv("RUNAI_CLIENT_ID"), "Run:AI client ID")
	rootCmd.Flags().StringVar(&clientSecret, "client-secret", os.Getenv("RUNAI_CLIENT_SECRET"), "Run:AI client secret")
	rootCmd.Flags().StringVar(&baseURL, "base-url", getEnvOrDefault("RUNAI_BASE_URL", "https://api.run.ai"), "Run:AI API base URL")
	rootCmd.Flags().IntVar(&interval, "interval", 3*60*60, "Interval between API calls in seconds (default: 3 hours)")
	rootCmd.Flags().StringVar(&logLevel, "log-level", "INFO", "Logging level (DEBUG, INFO, WARNING, ERROR)")
	rootCmd.Flags().StringVar(&kubeconfigPath, "kubeconfig", "", "Path to kubeconfig file to update runai-api user token")
}

func getEnvOrDefault(key, defaultValue string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return defaultValue
}

func runClient(cmd *cobra.Command, args []string) {
	if clientID == "" || clientSecret == "" {
		fmt.Println("Please provide --client-id and --client-secret or set RUNAI_CLIENT_ID and RUNAI_CLIENT_SECRET in your environment or .env file.")
		os.Exit(1)
	}

	// Parse log level
	level, err := logrus.ParseLevel(logLevel)
	if err != nil {
		fmt.Printf("Invalid log level: %s\n", logLevel)
		os.Exit(1)
	}

	// Create client
	runaiClient := client.NewRunAIClient(clientID, clientSecret, baseURL, kubeconfigPath)
	runaiClient.SetLogLevel(level)

	// Main loop
	for {
		workloads, err := runaiClient.GetWorkloads()
		if err != nil {
			runaiClient.Logger.WithError(err).Error("Failed to get workloads")
		} else {
			// Pretty print workloads
			jsonData, err := json.MarshalIndent(workloads, "", "  ")
			if err != nil {
				runaiClient.Logger.WithError(err).Error("Failed to marshal workloads")
			} else {
				fmt.Println(string(jsonData))
			}
		}

		runaiClient.Logger.Infof("Sleeping for %d seconds...", interval)
		time.Sleep(time.Duration(interval) * time.Second)
	}
}

func main() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
