#!/bin/sh

if [ -z "$RUNAI_MPI_NUM_WORKERS" ]; then
    echo "Environment variable 'RUNAI_MPI_NUM_WORKERS' does not exist"
    exit 1
fi

if [ -n "$RUNAI_SLEEP_SECS" ]; then
    echo "Sleeping for $RUNAI_SLEEP_SECS seconds"
    sleep $RUNAI_SLEEP_SECS
fi

echo "Running with $RUNAI_MPI_NUM_WORKERS workers"
# arguments taken from: https://github.com/kubeflow/mpi-operator/blob/v0.3.0/examples/v2beta1/tensorflow-benchmarks.yaml
mpirun --allow-run-as-root -np $RUNAI_MPI_NUM_WORKERS -bind-to none -map-by slot -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib python /examples/tensorflow2_synthetic_benchmark.py --num-batches-per-iter 10 --num-iters 1000
