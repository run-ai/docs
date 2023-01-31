
# Compute resource introduction

A compute resource is a mandatory building block for the creation of a workspace (See also <span style="text-decoration:underline;">Create Compute resource</span>). \
 \
One option would be that an administrator builds the compute resources for data science teams to consume or empower data scientists with the ability to also build compute resources. \


This building block represents a resource request to be used by the workspace (for example 0.5 GPU, 8 cores & 200 [Mb] of CPU memory). When a workspace is activated, the scheduler looks for a node that answers that request. \
 \
 A request is composed of one or more of the following resources: \




* GPU resources
* CPU memory resources
* CPU cores resources

 \


<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


Compute resource request form \


When a compute resource is created, its scope of relevancy can be set to be of a specific single project (e.g. “Project A”) or of the entire Tennant, which results in scope relevancy of all projects (current projects and also any future ones).



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


Project selection when creating a compute resource

In order to reduce noise and increase context, data scientists can view & use only environments that are in their scope of relevancy.



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


Compute resources grid
