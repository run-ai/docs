This is the main quickstart but based on Docker images from NVIDIA NGC.
The motivation was to create a Docker image with CUDA 11 to support A100.
It required changes both in the Dockerfile and in the Python script itself.
We were able to build images based on CUDA 10 and 11.
The CUDA 11 image works on A100.
The CUDA 10 image does not work on K80 as it has a too low compute capability.
