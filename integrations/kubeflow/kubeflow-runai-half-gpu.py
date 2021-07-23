from kfp import dsl, components
import kfp.gcp as gcp

def training_op():
    return dsl.ContainerOp(
        name='train',
        image='gcr.io/run-ai-demo/quickstart',
        command=["./entrypoint.sh"],
        arguments=[],
        container_kwargs={'image_pull_policy': 'IfNotPresent'},
        pvolumes={}
    )

@dsl.pipeline(
    name='qshf',
    description='Run:AI quickstart training model'
)
def training_pipeline():

    _training = training_op()
    _training.set_retry(5, "Always")
    _training.container.set_cpu_limit('1')
    _training.execution_options.caching_strategy.max_cache_staleness = "P0D"

    #.........RUNAI......................................
    _training.add_pod_label('runai', 'true')
    _training.add_pod_label('project', '<PROJECT>')
    _training.add_pod_annotation('gpu-fraction', '0.5')
    #````````````````````````````````````````````````````

