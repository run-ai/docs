from kubernetes import client, config
import time

def is_zombie_jupyter_service(service):
    if service.metadata.namespace.startswith("runai") and (service.metadata.name.endswith("jupyter") or service.metadata.labels.get("jupyter", False)):
        if service.spec.selector and "release" in service.spec.selector:
            jobName = service.spec.selector["release"]
            c = client.CustomObjectsApi()
            try:
                c.get_namespaced_custom_object_status(
                    group="run.ai",        
                    version="v1",
                    plural="runaijobs",
                    namespace=service.metadata.namespace,
                    name=jobName
                )
            except Exception as e:
                if e.status == 404:
                    return True
                else:
                    print(e)
    return False
        
def main():
    start = time.time()
    num_of_zombie_services = 0
    config.load_kube_config()
    v1 = client.CoreV1Api()
    svcs = v1.list_service_for_all_namespaces(watch=False, limit=50)
    while svcs:
        logs = []
        for service in svcs.items:
            if is_zombie_jupyter_service(service):
                num_of_zombie_services += 1
                print("ZOMBIE JUPYTER SERVICE. On namespace: %s, service: %s" % (service.metadata.namespace, service.metadata.name))
        if svcs.metadata._continue:
            svcs = v1.list_service_for_all_namespaces(watch=False, _continue=svcs.metadata._continue, limit=50)
        else:
            svcs = None
    t = time.time() - start    
    print("Summary. zombie: %d, seconds: %d" % (num_of_zombie_services, t))

if __name__ == "__main__":
    main()