from kfp import dsl, components

def training_op():
    return dsl.ContainerOp(
        name='runai-gpu1',
        image='gcr.io/run-ai-demo/quickstart',
        command=["./entrypoint.sh"],
        arguments=[],
        container_kwargs={'image_pull_policy': 'IfNotPresent'},
        pvolumes={}
    )

@dsl.pipeline(
    name='runai-gpu1',
    description='Run:AI quickstart training model'
)
def training_pipeline():

    _training = training_op()
    _training.set_retry(10, "Always")
    _training.container.set_gpu_limit(1)
    _training.container.set_cpu_limit('1')
    _training.execution_options.caching_strategy.max_cache_staleness = "P0D"
    #.........RUNAI......................................
    _training.add_pod_label('runai', 'true')
    _training.add_pod_label('project', '<PROJECT>')
    #````````````````````````````````````````````````````

