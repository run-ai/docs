
# Environment introduction

An environment is a mandatory building block for the creation of a workspace (See also [Create Environment](#xxxx)). 

The environment consists of the URL path for the container image as well as the image pull policy. It exposes all the necessary tools (either open source, 3rd party, or even custom ones) alongside their connection interfaces (See also [External URL](#xxx), [External node port])#xxx) and the container ports.



![](images/env-tools.png)


In addition, the environment consists of a command, arguments, and environment variables, as well as the user identity who is allowed to run commands in the container.


