#!/bin/sh

export gpus=`nvidia-smi --list-gpus | wc -l`
echo "Running on $gpus GPU(s)"
horovodrun -np $gpus -H localhost:$gpus python3 main.py "$@"
