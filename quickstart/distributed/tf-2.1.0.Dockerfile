# inspired by mpioperator/tensorflow-benchmarks:0.3.0 (https://github.com/kubeflow/mpi-operator/blob/v0.3.0/examples/tensorflow-benchmarks/Dockerfile)

FROM horovod/horovod:0.19.3-tf2.1.0-torch-mxnet1.6.0-py3.6-gpu

# mpi-operator mounts the .ssh folder from a Secret. For that to work, we need
# to disable UserKnownHostsFile to avoid write permissions.
# Disabling StrictModes avoids directory and files read permission checks.
RUN echo "    UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    sed -i 's/#\(StrictModes \).*/\1no/g' /etc/ssh/sshd_config

COPY ./entrypoint-horovod-example.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
