
# Environment introduction

An environment is a mandatory building block for the creation of a workspace (See also <span style="text-decoration:underline;">Create Environment</span>). \
 \
One option would be that an administrator builds the environments for data science teams to consume or empower data scientists with the ability to also build environments.

 \
The environment consists of the URL path for the container image as well as the image pull policy. It exposes all the necessary tools (either open source, 3rd party, or even custom ones) alongside their connection interfaces (See also <span style="text-decoration:underline;">External URL</span>, <span style="text-decoration:underline;">External node port</span>) and container’s ports.



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


Environment’s tools configuration

 \
In addition, the environment consists of a command, arguments, and environment variables, as well as the user identity who is allowed to run commands in the container.


