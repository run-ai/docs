#/bin/sh
dsl-compile --py kubeflow-runai-one-gpu.py --output kubeflow-runai-one-gpu.tar.gz
dsl-compile --py kubeflow-runai-half-gpu.py --output kubeflow-runai-half-gpu.tar.gz
