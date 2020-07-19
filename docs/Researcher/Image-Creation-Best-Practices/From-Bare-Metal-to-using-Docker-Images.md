# <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Introduction</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">Some researchers do data-science on _bare metal_. The term bare-metal relates to connecting to a server and working directly on its operating system and disks.&nbsp;</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">This is the fastest way to start working, but it introduces problems when the data science organization scales:</span>

*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">More researchers mean that the machine resources need to be efficiently shared</span>
*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">Researchers need to collaborate and share data, code, and results</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">To overcome that, people working on bare-metal typically write scripts to gather data, code and code dependencies. This soon becomes an overwhelming task.</span>

<div>
<h1><span>Why Use Docker Images?</span></h1>
<p><span>Docker images and 'containerization' in general provide a level of abstraction which, by large, frees developers and researchers from the mundane tasks of 'setting up an environment'. The image is an operating system by itself and thus the 'environment' is by large, a part of the image.&nbsp;</span></p>
<p><span>When a docker image is instantiated, it creates a&nbsp;<em>container<strong>.&nbsp;</strong></em>A container is the running manifestation of a docker image.&nbsp;</span></p>
<h1><span>Moving a Data Science Environment to Docker</span></h1>
</div>

<div>A data science environment typically includes:</div>

<ul><li><font face="arial, sans-serif">Training data.</font></li><li><font face="arial, sans-serif">Machine Learning (ML) code and inputs.&nbsp;</font></li><li><font face="arial, sans-serif">Libraries: Code dependencies that must be installed before the ML code can be run.</font></li></ul>

## <span style="font-family: arial, sans-serif;">Training data</span>

<font face="arial, sans-serif">Training data is usually significantly&nbsp;large (from several Gigabytes&nbsp;to Petabytes) and is read-only in nature.&nbsp;Thus, training data is typically left outside of the docker image.&nbsp;</font>

<font face="arial, sans-serif">Instead, the data is <em>mounted</em><strong>&nbsp;</strong>onto the image when it is instantiated. Mounting a volume allows the code within the container to access the data as though it was within a directory on the local file system.</font>

<font face="arial, sans-serif">The best practice is to store the training data on a shared file system. This allows the data to be accessed uniformly on whichever machine the researcher is currently using, allowing the researcher to easily migrate between machines.</font>

<span style="font-family: arial, sans-serif;">Organizations without a shared file system typically write scripts to copy data from machine to machine.&nbsp;</span>

## <span style="font-family: arial, sans-serif;">Machine Learning Code and Inputs</span>

<div><font face="arial, sans-serif">As a rule, code needs to be saved and versioned in a <strong>code repository</strong>.&nbsp;</font></div>

<div><font face="arial, sans-serif">There are two alternative practices:</font></div>

*   The code resides in the image and is being periodically pulled from the repository. This practice requires building a new container image each time a change is introduced to the code.
*   When a shared file system exists, the code can reside outside the image on a shared disk and mounted via a volume onto the container.&nbsp;

<div><font face="arial, sans-serif">Both practices are valid.&nbsp;</font></div>

<div><font face="arial, sans-serif">Inputs to machine learning models and artifacts of training sessions, like model checkpoints, are also better stored in and loaded from a shared file system.</font></div>

<h2><font face="arial, sans-serif">Code Dependencies</font></h2>

<div><span style="font-family: arial, sans-serif;">Any code has code dependencies. These libraries must be installed for the code to run. As the code is changing, so do the dependencies.&nbsp;</span></div>

<div><span style="font-family: arial, sans-serif;">ML Code is typically python and python dependencies are typically declared together in a single <em>requirements.txt</em> file which is saved together with the code.</span></div>

<div><span style="font-family: arial, sans-serif;">The best practice is to have your docker startup script (see below) run this file using <em>pip install -r&nbsp;requirements.txt</em>. This allows the flexibility of adding and removing code dependencies dynamically.</span></div>

<div><span style="font-family: arial, sans-serif;"></span></div>

# <span style="font-family: arial, sans-serif;">ML Lifecycle: Build and Train</span>

<div>
<p>Deep learning workloads can be divided into two generic types:</p>
<ul>
<li>Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter Notebook, remote PyCharm or similar and accesses GPU resources directly<span>. Build workloads are typically meant for debug and development sessions.&nbsp;</span>
</li>
<li>Unattended "training" sessions.&nbsp;<span>Training is characterized by a machine learning run that has a start and a finish.&nbsp;</span>With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the data scientist can examine the results<span>. A Train session can take from a few minutes to a couple of days. It can be interrupted in the middle and later restored (though the data scientist should save checkpoints for that purpose). Training workloads typically utilize large percentages of the GPU and at the end of the run automatically frees the resources.</span>
</li>
</ul>
</div>

<div>
<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">Getting your docker ready is also a matter of which type of workload you are&nbsp;</font>currently<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">&nbsp;running.</font>
</div>

<div></div>

## Build Workloads

<div>With "build" you are actually coding and debugging small experiments. You are<span>&nbsp;</span><strong>interactive</strong>. In that mode, you can typically take a well known standard image (e.g.&nbsp;<a data-saferedirecturl="https://www.google.com/url?q=https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow&amp;source=gmail&amp;ust=1592498144070000&amp;usg=AFQjCNGTAief8-leIAVR4wSzfzvkGEphDA" href="https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow" rel="noopener" target="_blank">https://ngc.nvidia.com/<wbr/>catalog/containers/nvidia:<wbr/>tensorflow</a>) and use it directly.&nbsp;</div>

<div>Start a docker container by running:</div>

<pre>docker run -it .... "the well known image "&nbsp; -v /where/my/code/resides bash&nbsp;</pre>

<div></div>

<div>You get a shell prompt to a container with a mounted volume of where your code is. You can then install your&nbsp;prerequisites and run your code via ssh.</div>

<div>You can also access the container remotely from tools such as PyCharm, Jupyter Notebook and more. In this case, the docker image needs to be customized to install the "server software" (e.g. a Jupyter Notebook service).</div>

<div></div>

## Training Workloads

<div><font face="arial, sans-serif">For training workloads you can use a well-known image (e.g. nvidia-tensorflow image from the link above) but more often then not, you want to create your own docker image. The best practice is to use the well-known image (e.g. nvidia-tensorflow from above) as a <strong>base image</strong> and add your own customizations <strong>on top</strong> of it. To achieve that, you create a<span>&nbsp;</span><em>Dockerfile. A&nbsp;</em>Dockerfile is a declarative&nbsp;way to build a docker image and is built in layers. e.g.:</font></div>

<ol><li><font face="arial, sans-serif">Base image is nvidia-tensorflow</font></li><li><font face="arial, sans-serif">Install popular software.</font></li><li><font face="arial, sans-serif">(Optional) Run a script.&nbsp;</font></li></ol>

The script can be part of the image or can be provided as part of the command line to run the docker. It will typically include additional dependencies to install as well as a reference to the ML code to be run.&nbsp;

Best practice for running training workloads is to test the container image in a "build" session and then send it for execution as a training job.&nbsp;For further information on how to set up and parameterize a training workload via docker or runai see&nbsp;<https://support.run.ai/hc/en-us/articles/360012065440-Converting-your-Workload-to-use-Unattended-Training-Execution>&nbsp;

<div><font face="arial, sans-serif">&nbsp;</font></div>

<div></div>