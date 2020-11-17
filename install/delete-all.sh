#/bin/sh

kubectl delete psp runai-admission-controller runai-grafana runai-grafana-test runai-init-ca runai-kube-state-metrics runai-local-path-provisioner runai-prometheus-node-exporter runai-prometheus-operator-operator runai-prometheus-operator-prometheus runai-prometheus-pushgateway runai-nginx-ingress runai-nginx-ingress-backend mpi-operator runai-job-controller runai-prometheus-operator-admission
kubectl delete clusterrole init-ca psp-runai-kube-state-metrics psp-runai-prometheus-node-exporter runai runai-admission-controller  runai-grafana-clusterrole runai-kube-state-metrics runai-operator runai-prometheus-operator-operator runai-prometheus-operator-operator-psp runai-prometheus-operator-prometheus runai-prometheus-operator-prometheus-psp runai-local-path-provisioner mpi-operator runai-nginx-ingress runai-job-controller runai-nfs-client-provisioner-runner
kubectl delete clusterrolebinding default-sa-admin init-ca psp-runai-kube-state-metrics psp-runai-prometheus-node-exporter runai runai-admission-controller runai-grafana-clusterrolebinding runai-kube-state-metrics runai-operator runai-prometheus-operator-operator runai-prometheus-operator-operator-psp runai-prometheus-operator-prometheus runai-prometheus-operator-prometheus-psp runai-local-path-provisioner mpi-operator runai-nginx-ingress runai-job-controller run-runai-nfs-client-provisioner
kubectl delete MutatingWebhookConfiguration runai-fractional-gpus runai-label-project runai-mutating-webhook runai-prometheus-operator-admission runai-reporter-library runai-node-affinity runai-resource-gpu-factor
kkubectl delete validatingWebhookConfiguration runai-prometheus-operator-admission runai-validate-elastic runai-validate-fractional
kubectl delete pc build interactive-preemptible train runai-critical
kubectl delete sc local-path nfs-client
kubectl delete department default
kubectl delete service -n kube-system runai-prometheus-operator-coredns runai-prometheus-operator-kube-controller-manager runai-prometheus-operator-kube-etcd runai-prometheus-operator-kube-proxy runai-prometheus-operator-kube-scheduler runai-prometheus-operator-kubelet
