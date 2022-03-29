FROM mpioperator/tensorflow-benchmarks:0.3.0

RUN mkdir /cifar10
COPY ./cifar-10 /cifar10
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
