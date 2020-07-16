#Prerquisties
  Run:AI helps organizations optimize the resources of a data science operation.
  Below are the prerequisites of the Run:AI solution.&nbsp;


&#10;  **Important note**: This document relates to the cloud version of
  Run:AI and discusses the prerequisites for the GPU Cluster.&nbsp;

# Kubernetes Software
&#10;  Run:AI requires Kubernetes 1.15 or above. Kubernetes 1.17 is recommended (as
  of June 2020)

# Hardware Requirements

  
- **Kubernetes Master:** Run:AI runs on top of Kubernetes. If your GPU cluster already has Kubernetes, then no further hardware is required for Kubernetes. If you are installing Kubernetes, it is best (not mandatory) to have a separate machine that will act as the *Kubernetes master*. Such a machine is best with 4 CPUs and 8 GB RAM (with no special disk requirements)&nbsp;
      
  
- **Shared data volume:** Run:AI, via Kubernetes,&nbsp;abstracts away the machine on which a container is running.&nbsp;For containers to run anywhere, they need to be able to access data from any machine in a uniform way. Typically, this requires a NAS (Network-attached storage) which allows any node to connect to storage outside the box.
      

# Network Requirements
&#10;  Run:AI user interface runs from the cloud. All container nodes must be able to
  connect to the Run:AI cloud.&nbsp;Inbound connectivity (connecting from the cloud
  into nodes) is not required. If outbound connectivity is proxied/limited, the
  following exceptions should be applied:&nbsp;

## During Installation
&#10;  Run:AI requires an installation over the Kubernetes cluster. The installation
  access the web to download various images and registries. Some organizations
  place limitations on what you can pull from the internet. The following list
  shows the various solution components and their origin:&nbsp;


<table style="width: 707px; margin-left: 0px; margin-right: auto;" border="1">
  <tbody>
    <tr>
      <th style="width: 114.375px;" scope="row">Name</th>
      <th style="width: 308.92px;" scope="row">Description</th>
      <th style="width: 227.102px;" scope="row">URLs</th>
      <th style="width: 43.4659px;" scope="row">Ports</th>
    </tr>
    <tr>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 104.375px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Run:AI&nbsp; Repository</font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 298.92px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">
              The Run:AI Package Repository is hosted on Run:AI’s account
              on Google Cloud
            </font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 217.102px;">
        &#10;          <font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">
            <span style="font-size: 15px;">[<span>runai-charts.storage.googleapis.com</span>](http://runai-charts.storage.googleapis.com/)<span>&nbsp;</span></span>
          </font>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 33.4659px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font>
&#10;          </span>
        
      </td>
    </tr>
    <tr>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 104.375px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Docker Images Repository</font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 298.92px;">
        &#10;          <span style="font-weight: 400;">
            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Various Run:AI images</font>
          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 217.102px;">
        &#10;          [
            <span>
              <font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">hub.docker.com</font>
            </span>
          ](http://hub.docker.com/)
        
        &#10;          <span>
            <font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">gcr.io/run-ai-prod&nbsp;</font>
          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 33.4659px;">
        &#10;          <span style="font-weight: 400;">
            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font>
&#10;          </span>
        
      </td>
    </tr>
    <tr>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 104.375px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Docker Images Repository</font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 298.92px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Various third party Images</font>
          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 217.102px;">
        &#10;          <font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">
            <span style="font-size: 15px;">[<span>quay.io</span>](http://quay.io/)&nbsp;</span>
          </font>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 33.4659px;">
        &#10;          <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">
            <span style="font-size: 15px;">443&nbsp;</span>
          </font>
        
      </td>
    </tr>
  </tbody>
  <caption>
    &nbsp;
  </caption>
</table>
&#10; 
## Post Installation
In addition, once running, Run:AI will send metrics to two sources:


<table style="margin-left: 0px; margin-right: auto;" border="1">
  <tbody>
    <tr style="height: 22px;">
      <th style="width: 116px; height: 22px;" scope="row">Name</th>
      <th style="width: 314px; height: 22px;" scope="row">Description</th>
      <th style="width: 215px; height: 22px;" scope="row">URLs</th>
      <th style="width: 42px; height: 22px;" scope="row">Ports</th>
    </tr>
    <tr>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 106px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Grafana&nbsp;</font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 304px;">
        &#10;          Grafana&nbsp;&nbsp; 
          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Metrics Server</font>
&#10;          </span>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 205px;">
        prometheus-us-central1.grafana.net
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 32px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font>
&#10;          </span>
        
      </td>
    </tr>
    <tr>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 106px;">
        &#10;          <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Run:AI</font>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 304px;">
        &#10;          &nbsp;Run:AI&nbsp;
          <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Cloud instance</font>
        
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 205px;">
        &#10;          <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">
            <span style="font-size: 15px;">app.run.ai</span>
          </font>
        
        &nbsp;
      </td>
      <td style="padding-top: 6px; padding-right: 6px; padding-bottom: 6px; padding-left: 6px; width: 32px;">
        &#10;          <span style="font-weight: 400;">
&#10;            <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font>
&#10;          </span>
        
      </td>
    </tr>
  </tbody>
</table>
&#10; 
# User requirements
**Usage of containers and images:**&nbsp;The individual researcher's
  work is based on container images. Containers allow IT to create standard software
  environments based on mix and match of various cutting-edge software&nbsp;
