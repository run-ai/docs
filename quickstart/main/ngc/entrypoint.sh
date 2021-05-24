#!/bin/bash

export gpus=`nvidia-smi --list-gpus | wc -l`
echo "Running on $gpus GPU(s)"

if [[ $RUNAI_CUDA_VERSION = "10.0" ]]
then
    # the 10.0 Docker image has horovod 0.15.1 installed which does not have `horovodrun`.
    # we therefore use a different command taken from the documentation at
    # https://github.com/horovod/horovod/blob/v0.15.1/docs/running.md#running-horovod
    mpirun -np $gpus -H localhost:$gpus --allow-run-as-root -bind-to none -map-by slot -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib python main.py "$@"
else
    horovodrun -np $gpus -H localhost:$gpus python main.py "$@"
fi
