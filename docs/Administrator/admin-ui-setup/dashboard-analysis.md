## Jobs with idle GPUs

__Description__: locate Jobs with idle GPUs, defined as GPUs with 0% GPU utilization for more than 5 minutes. 

__How to__: view the following panel:

![](https://lh5.googleusercontent.com/0TQVmGjJ7POldL8ALW0UzKohykHsFruqFkW4V8LsVJNJUZvJmBmfMKmcyuqxKtJPja2Skv2Lf_wHbgCTPV-eseiwFDNq5vZzM7vrBXIj_bJUTqotIlDPIpsnbWB3AcySnb5NwDQL)

__Analysis and Suggested actions__:

| Action   | Analysis |
|----------|--------|
| Interactive jobs are too frequently idle | *  Consider setting time limits for interactive jobs through the Projects tab. </br>  *  Consider also reducing GPU quotas for specific projects to encourage users to run more training jobs as opposed to interactive jobs (note that interactive jobs can not use more than the GPU quota assigned to their project). |
| Training jobs are too frequently idle | Identify and notify the right users and work with them to improve the utilization of their training scripts |


## Jobs with an Error

__Description__: Search for jobs with an error status. These jobs may be holding GPUs without actually using them. 

__How to__: view the following panel:

![](https://lh6.googleusercontent.com/QdFKViIGeC_cAzbupw9EOyHXe-29i5hnw9UwQMVJNdYZCRIRDe7xh75ge2Tn87J2Ks_EaSnhv5kZEfyucDfFOPsr_qwyB9avVt2VhKXwd4IlUUOjnc3T-yivflNrylhmGwMq-CbF)

__Analysis and Suggested actions__:

Discuss with Job owner, then go to Run:AI CLI and delete these jobs so as to free the resources for other users. 
