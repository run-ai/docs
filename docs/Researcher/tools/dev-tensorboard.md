# Connecting to TensorBoard
 
Once you launch a Deep Learning workload using Run:ai, you may want to view its progress. A popular tool for viewing progress is [TensorBoard](https://www.tensorflow.org/tensorboard){target=_blank}.

The document below explains how to use TensorBoard to view the progress or a Run:ai Job.


## Submit a Workload

When you submit a workload, your workload must save TensorBoard logs which can later be viewed. Follow [this](https://www.tensorflow.org/tensorboard/get_started){target=_blank} document on how to do this. You can also view the Run:ai sample code [here](https://github.com/run-ai/docs/blob/master/quickstart/unattended-execution/main.py){target=_blank}.

The code shows:

* A reference to a log directory:

``` python
log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
```

* A registered Keras callback for TensorBoard:

``` python
tensorboard_callback = TensorBoard(log_dir=log_dir, histogram_freq=1)

model.fit(x_train, y_train,
        ....
        callbacks=[..., tensorboard_callback])
```

The `logs` directory must be saved on a Network File Server such that it can be accessed by the TensorBoard Job. For example, by running the Job as follows:

```
runai submit train-with-logs -i tensorflow/tensorflow:1.14.0-gpu-py3 \
  -v /mnt/nfs_share/john:/mydir -g 1  --working-dir /mydir --command -- ./startup.sh
```

Note the volume flag (`-v`) and working directory flag (`--working-dir`). The logs directory will be created on `/mnt/nfs_share/john/logs/fit`.


## Submit a TensorBoard Workload

There are two ways to submit a TensorBoard Workload: via the Command-line interface or the user interface

## Submit via the User interface

* Within the user interface go to the Job list.
* Select `New Job` on the top right.
* Select `Interactive` at the top. 
* Add an image that supports TensorBoard. For example: `tensorflow/tensorflow:latest`.
* Select the `TensorBoard` button.
* Add a mounted volume on which TensorBoard logs exist. The example above uses `/mnt/nfs_share/john`. Map to `/mydir`
* Add `/mydir` to the `TensorBoard Logs Directory`. 

Submit the Job. When running, select the job and press `Connect` on the top right.

## Submit via the Command-line interface

Run the following:

```
runai submit tb -i tensorflow/tensorflow:latest --interactive --service-type=portforward --port 8888:8888  --working-dir /mydir  -v /mnt/nfs_share/john:/mydir  -- tensorboard --logdir logs/fit --port 8888 --host 0.0.0.0
```

The terminal will show the following: 

``` shell
The job 'tb' has been submitted successfully
You can run `runai describe job tb -p team-a` to check the job status
INFO[0006] Waiting for job to start
Waiting for job to start
INFO[0014] Job started
Open access point(s) to service from localhost:8888
Forwarding from 127.0.0.1:8888 -> 8888
Forwarding from [::1]:8888 -> 8888
```

Browse to [http://localhost:8888/](http://localhost:8888/){target=_blank} to view TensorBoard.

!!! Note
  A single TensorBoard Job can be used to view multiple deep learning Jobs, provided it has access to the logs directory for these Jobs. 

You can also submit a TensorBoard Job via the user interface. In which case, instead of `portforward` you will need to select a different service type. If the URL to the TensorBoard job includes a path, you may need to use the TensorBoard flag `--path_prefix`. For example, if your access point is [acme.com/tensorboard1](http://localhost) add  `--path_prefix /tensorboard1`.