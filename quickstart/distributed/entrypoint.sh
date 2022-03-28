#!/bin/sh

if [ -z "$RUNAI_MPI_NUM_WORKERS" ]; then
    echo "Environment variable 'RUNAI_MPI_NUM_WORKERS' does not exist"
    exit 1
fi

echo "Running with $RUNAI_MPI_NUM_WORKERS workers"
mpirun --allow-run-as-root -np $RUNAI_MPI_NUM_WORKERS -bind-to none -map-by slot -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model=resnet20 --num_batches=1000000 --data_name cifar10 --data_dir /cifar10 --batch_size=64 --variable_update=horovod
