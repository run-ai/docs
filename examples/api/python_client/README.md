# NVIDIA Run:AI API Python Client

A professional Python client for the NVIDIA Run:AI API. This client authenticates using the application method (clientID/clientSecret), periodically calls the GET Workloads API, and automatically refreshes the token if it expires.

## Features
- Authenticate using client credentials (clientID/clientSecret)
- Periodically call the GET Workloads API (default: every 3 hours)
- Automatically refresh token on 401 Unauthorized
- Configurable via CLI, environment variables, or `.env` file
- Logging with configurable verbosity
- Optionally updates your kubeconfig with the latest NVIDIA Run:AI API token under a `runai-api` user

## Installation

1. **Create and activate a virtual environment (recommended):**

   On macOS/Linux:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
   On Windows:
   ```bash
   python -m venv venv
   venv\Scripts\activate
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
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

- `--client-id`         NVIDIA Run:AI client ID (overrides env)
- `--client-secret`     NVIDIA Run:AI client secret (overrides env)
- `--base-url`          NVIDIA Run:AI API base URL (default: https://api.run.ai)
- `--interval`          Interval between API calls in seconds (default: 10800 = 3 hours)
- `--log-level`         Logging level (DEBUG, INFO, WARNING, ERROR)
- `--kubeconfig`        Path to kubeconfig file to update the `runai-api` user token (optional)

## Kubeconfig Integration

If you provide the `--kubeconfig` option, the client will automatically set or update a user named `runai-api` in your kubeconfig file with the latest API token. This is useful for integrating with Kubernetes clusters that use NVIDIA Run:AI authentication.

- The token is updated after every successful authentication and on token refresh (e.g., after a 401 error).
- If the user does not exist, it will be created.
- Example usage:

```bash
python -m runai_python_client.main --kubeconfig ~/.kube/config
```

## Usage

```bash
python -m runai_python_client.main --client-id <your_id> --client-secret <your_secret>
```

Or simply:

```bash
python -m runai_python_client.main
```

If you have set the environment variables or a `.env` file.

## Example Output

```
2024-05-01 12:00:00 INFO RunAIClient: Obtained new token.
2024-05-01 12:00:00 INFO RunAIClient: Updated kubeconfig at /Users/you/.kube/config with new token.
2024-05-01 12:00:01 INFO RunAIClient: Successfully fetched workloads.
[{'id': 'workload1', ...}, ...]
2024-05-01 12:00:01 INFO root: Sleeping for 10800 seconds...
```

## Troubleshooting
- Ensure your credentials are correct and have API access.
- Use `--log-level DEBUG` for more detailed output.
- If you see authentication errors, check your client ID/secret and API base URL.
- If you see kubeconfig errors, ensure the file is writable and valid YAML.

## Extending
- Add more API calls by extending `RunAIClient` in `client.py`.
- Use the `utils.py` module for logging and environment helpers.
