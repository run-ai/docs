import os
import time
import argparse
import logging
from dotenv import load_dotenv
from runai_python_client.client import RunAIClient
import pprint

def main():
    load_dotenv()
    parser = argparse.ArgumentParser(description="Run:AI API Client - Periodically fetch workloads.")
    parser.add_argument('--client-id', type=str, default=os.getenv('RUNAI_CLIENT_ID'), help='Run:AI client ID')
    parser.add_argument('--client-secret', type=str, default=os.getenv('RUNAI_CLIENT_SECRET'), help='Run:AI client secret')
    parser.add_argument('--base-url', type=str, default=os.getenv('RUNAI_BASE_URL', 'https://api.run.ai'), help='Run:AI API base URL')
    parser.add_argument('--interval', type=int, default=3*60*60, help='Interval between API calls in seconds (default: 3 hours)')
    parser.add_argument('--log-level', type=str, default='INFO', help='Logging level (DEBUG, INFO, WARNING, ERROR)')
    parser.add_argument('--kubeconfig', type=str, default=None, help='Path to kubeconfig file to update runai-api user token')
    args = parser.parse_args()

    logging.basicConfig(level=getattr(logging, args.log_level.upper()), format='%(asctime)s %(levelname)s %(name)s: %(message)s')

    if not args.client_id or not args.client_secret:
        print("Please provide --client-id and --client-secret or set RUNAI_CLIENT_ID and RUNAI_CLIENT_SECRET in your environment or .env file.")
        exit(1)

    client = RunAIClient(
        client_id=args.client_id,
        client_secret=args.client_secret,
        base_url=args.base_url,
        kubeconfig_path=args.kubeconfig
    )

    while True:
        workloads = client.get_workloads()
        if workloads is not None:
            pprint.pprint(workloads)
        else:
            logging.error("No workloads returned.")
        logging.info(f"Sleeping for {args.interval} seconds...")
        time.sleep(args.interval)

if __name__ == "__main__":
    main() 