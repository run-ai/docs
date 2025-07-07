# Run:AI API Go Client

A professional Go client for the Run:AI API. This client authenticates using the application method (clientID/clientSecret), periodically calls the GET Workloads API, and automatically refreshes the token if it expires.

## Features
- Authenticate using client credentials (clientID/clientSecret)
- Periodically call the GET Workloads API (default: every 3 hours)
- Automatically refresh token on 401 Unauthorized
- Configurable via CLI, environment variables, or `.env` file
- Structured logging with configurable verbosity
- Optionally updates your kubeconfig with the latest Run:AI API token under a `runai-api` user

## Installation

1. **Clone or download this repository**

2. **Install dependencies:**

   ```bash
   go mod tidy
   ```

3. **Build the binary:**

   ```bash
   go build -o runai-go-client cmd/main.go
   ```

## Configuration

You can configure the client using environment variables, a `.env` file, or CLI arguments.

### Environment Variables / .env

```
RUNAI_CLIENT_ID=your_client_id_here
RUNAI_CLIENT_SECRET=your_client_secret_here
# Optional: override the default API base URL
# RUNAI_BASE_URL=https://api.run.ai
```

### CLI Arguments

- `--client-id`         Run:AI client ID (overrides env)
- `--client-secret`     Run:AI client secret (overrides env)
- `--base-url`          Run:AI API base URL (default: https://api.run.ai)
- `--interval`          Interval between API calls in seconds (default: 10800 = 3 hours)
- `--log-level`         Logging level (DEBUG, INFO, WARNING, ERROR)
- `--kubeconfig`        Path to kubeconfig file to update the `runai-api` user token (optional)

## Kubeconfig Integration

If you provide the `--kubeconfig` option, the client will automatically set or update a user named `runai-api` in your kubeconfig file with the latest API token. This is useful for integrating with Kubernetes clusters that use Run:AI authentication.

- The token is updated after every successful authentication and on token refresh (e.g., after a 401 error).
- If the user does not exist, it will be created.
- Example usage:

```bash
./runai-go-client --kubeconfig ~/.kube/config
```

## Usage

```bash
./runai-go-client --client-id <your_id> --client-secret <your_secret>
```

Or simply:

```bash
./runai-go-client
```

If you have set the environment variables or a `.env` file.

## Example Output

```
INFO[2024-05-01T12:00:00Z] Obtained new token
INFO[2024-05-01T12:00:00Z] Updated kubeconfig at /Users/you/.kube/config with new token
INFO[2024-05-01T12:00:01Z] Successfully fetched workloads
[
  {
    "id": "workload1",
    ...
  }
]
INFO[2024-05-01T12:00:01Z] Sleeping for 10800 seconds...
```

## Development

### Project Structure

```
runai_go_client/
├── cmd/
│   └── main.go              # CLI entry point
├── pkg/
│   ├── client/
│   │   └── runai_client.go  # Main client logic
│   └── kubeconfig/
│       └── kubeconfig.go    # Kubeconfig manipulation
├── go.mod                   # Go module definition
└── README.md               # This file
```

### Building

```bash
go build -o runai-go-client cmd/main.go
```

### Running Tests

```bash
go test ./...
```

## Troubleshooting
- Ensure your credentials are correct and have API access.
- Use `--log-level DEBUG` for more detailed output.
- If you see authentication errors, check your client ID/secret and API base URL.
- If you see kubeconfig errors, ensure the file is writable and valid YAML.

## Extending
- Add more API calls by extending the `RunAIClient` struct in `pkg/client/runai_client.go`.
- Use the `pkg/kubeconfig` package for kubeconfig manipulation helpers.
