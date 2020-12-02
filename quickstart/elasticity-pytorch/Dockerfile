FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-runtime

RUN pip install coloredlogs

RUN mkdir /workload

# Install the Run:AI Python library and its dependencies
RUN pip install runai prometheus_client==0.7.1

COPY ./main.py /workload/
COPY ./cifar-10-batches-py /workload/cifar-10-batches-py

WORKDIR /workload
ENTRYPOINT ["python", "main.py"]
