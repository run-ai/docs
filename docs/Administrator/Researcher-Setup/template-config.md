!!! Note
    Templates are currently not supported. 

---

# Configure Command-Line Interface Templates

## What are Templates?

Templates are a way to reduce the number of flags required when using the Command-Line Interface to start workloads. Using Templates the researcher can:

*   Review list of templates by running ``runai template list``
*   Review the contents of a specific template by running ``runai template get <template-name>``
*   Use a template by running ``runai submit --template <template-name>``

The purpose of this document is to provide the administrator with guidelines on how to create templates.

## Template Implementation

CLI Templates are implemented as_ Kubernetes <a href="https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/" target="_self">ConfigMaps</a>. A Kubernetes ConfigMap is the standard way to save cluster-wide settings.

To create a Run:AI CLI Template, you will need to save a ConfigMap on the cluster. The Run:AI CLI is then looking for ConfigMaps marked as Run:AI templates.

### Template Usage

The Researcher can use the Run:AI CLI to

Show a list of templates:

    runai template list

Showing the properties of a specific template:

    runai template get <my-template>

Use the template when submitting a workload

    runai submit <my-job> --template <my-template>

For further details, see the Run:AI command-line reference <a href="https://support.run.ai/hc/en-us/articles/360011548039-runai-template" target="_self">template</a> and <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">submit</a> functions.

## Template Syntax

A template looks as follows:

    apiVersion: v1
    kind: ConfigMap
    data:
    name: cli-template1
    description: "my first template"
    values: |
        image: gcr.io/run-ai-demo/quickstart
        gpu: 1
        elastic: true
    metadata:
    name: cli-template1
    namespace: runai
    labels:
        runai/template: "true"

Notes:

*   The template above set 3 defaults: a specific image, a default of 1 GPU and sets the "elastic" flag to true
*   The label runai/template marks the ConfigMap as a Run:AI template.
*   The name and description will show when using the _runai template list_ command

To store this template run:

    kubectl apply -f <template-file-name>

For a complete list of template values, see the end of this document

## The Default Template

The administrator can also set a default template that is always used on runai submit whenever a template is __not__ specified. To create a default template use the annotation runai/default: "true". Example:

    apiVersion: v1
    kind: ConfigMap
    data:
    name: cli-template1
    description: "my first template"
    values: |
        volume:
        - '/path/on/host:/dest/container/path'
    metadata:
    name: cli-template1
    namespace: runai
    annotations:
        runai/default: "true"
    labels:
        runai/template: "true"

## Flag Override Logic for Multi Values

If your template specifies 1 GPU and the Researcher adds the --gpu flag for 2 GPUs, the system will use the Researcher's 2 GPU as an override. 
Some flags, such as volume, ports, args accept __multiple__ values. Which bears the question XXX There are two override alternatives:

1. The flag

## Syntax of all Values

The following template sets all runai submit flags.

    apiVersion: v1
    kind: ConfigMap
    data:
    name: "all-cli-flags"
    description: "A sample showing all possible flag overrides via a template"
    values: |
        alwaysPullImage: false  # X
        args:                   
        - 'infinity'
        backoffLimit: 3         # X
        command:                # X
        - 'sleep'
        cpu: 1.5                
        cpuLimit: 3             
        elastic: false          # X
        environmentDefault:     
        - 'LEARNING_RATE=0.25'
        - 'TEMP=302'
        gpu: 1                  # X
        hostIPC: false          # X           
        hostNetwork: false      # X        
        image: ubuntu           # X
        interactive: true       # Yes, it created as an STS
        largeShm: false         # X              
        localImage: false       # X
        memory: 1G              
        memoryLimit: 2G         
        nodeType: "dgx-1"       # X   
        portsDefault:           
        - '80:8888'             
        - 9090
        preemptible: false      # X
        project: "team-ny"      
        runAsUser: true         # ?
        largeShm: false         # X
        serviceType: "loadbalancer"    
        ttlAfterFinish: 30              # X
        volumeDefault:                  
        - '/etc:/dest/container/path'   
        workingDir: "/tmp"              
    metadata:
    name: cli-all-flags
    namespace: runai
    labels:
        runai/template: "true"