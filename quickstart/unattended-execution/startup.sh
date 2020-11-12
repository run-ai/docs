#!/bin/bash


pip install -r requirements.txt

# the trap code is designed to send a stop (SIGTERM) signal to child processes, 
# thus allowing python code to catch the signal and execute a callback
trap 'trap " " SIGTERM; kill 0; wait' SIGTERM
python  -u main.py &
wait