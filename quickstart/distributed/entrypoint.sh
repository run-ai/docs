#!/bin/sh

if [ -z "$RUNAI_MPI_NUM_WORKERS" ]; then
    echo "Environment variable 'RUNAI_MPI_NUM_WORKERS' does not exist"
    exit 1
fi

echo "Running with $RUNAI_MPI_NUM_WORKERS workers"
horovodrun -np $RUNAI_MPI_NUM_WORKERS python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model=resnet20 --num_batches=1000000 --data_name cifar10 --data_dir /cifar10 --batch_size=64 --variable_update=horovod
