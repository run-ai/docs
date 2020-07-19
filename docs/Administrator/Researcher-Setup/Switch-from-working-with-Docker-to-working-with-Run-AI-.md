# Dockers, Images, and Kubernetes

Researchers are typically proficient in working with Docker. Docker is an isolation level above the operating system which allows creating your own bundle of the operating system + deep learning environment and packaging it within a single file. The file is called&nbsp;__a _docker image_.__

You create a&nbsp;___container___ by starting a docker image on a machine.

Run:AI is based on ___Kubernetes___.&nbsp;At its core, Kubernetes is a an orchestration software above Docker: Among other things, it allows location abstraction as to where the actual container is running. This calls for some adaptation to the researcher's workflow as follows.

# Image Repository

If your Kubernetes cluster contains a single GPU node (machine), then your image can reside on the node itself (in which case, when <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">submitting</a> workloads, the researcher must use the flag --local-image).

If your Kubernetes cluster contains more than a single node, then, to enable location abstraction, the image can no longer reside on the node itself.&nbsp; It must be relocated to an image repository. There are quite a few repository-as-a-service, most notably <a href="https://hub.docker.com/" target="_self">Docker hub</a>. Alternatively, the organization can install a private repository on-premise.

Day to day work with the image located remotely is almost identical to local work. The image name now contains its location. For example,&nbsp;_nvcr.io/nvidia/pytorch:19.12-py_3 is a PyTorch image that is located in nvcr.io which is the Nvidia image repository on the web.&nbsp;

# Data

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Deep learning is about data. It can be your code, the training data, saved checkpoints, etc.</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">If your Kubernetes cluster contains a single GPU node (machine), then your data can reside on the node itself.</span>

If your Kubernetes cluster contains more than a single node, then, to enable location abstraction, the data must sit outside the machine, typically on network storage. The storage must be uniformly mapped to your container when it starts (using the -v command).

# Working with Containers&nbsp;

Starting a container using docker usually involves a single command line with multiple flags. A typical example:&nbsp;

<pre>docker run --runtime=nvidia --shm-size 16G -it --rm -e HOSTNAME=`hostname` \<br/>    -v /raid/public/my_datasets:/root/dataset:ro \<br/>    nvcr.io/nvidia/pytorch:19.12-py3</pre>

The docker command ___docker run___ should be replaced with a Run:AI command ___runai submit___. The flags are usually the same but some adaptation is required. A complete list of flags can be found here: <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">https://support.run.ai/hc/en-us/articles/360011436120-runai-submit</a>&nbsp;.&nbsp;

There are similar commands to get a shell into the container (_runai bash_), get the container logs (_runai logs_) and more. For a complete list see the Run:AI CLI [reference](https://support.run.ai/hc/en-us/articles/360011434580-Introduction).&nbsp;

# Schedule an Onboarding Session

It is highly recommended to schedule an onboarding session for researchers with a Run:AI customer success professional. Run:AI can help with the above transition, but adding to that, we at Run:AI have also acquired a large body of knowledge on data science best practices which can help streamline the researcher work as well as save money for the organization.

Researcher onboarding material also appears here:&nbsp;<a href="https://support.run.ai/hc/en-us/articles/360012125099-Researcher-Onboarding-Presentation" target="_self">https://support.run.ai/hc/en-us/articles/360012125099-Researcher-Onboarding-Presentation</a>

&nbsp;