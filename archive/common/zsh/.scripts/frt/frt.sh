#!/bin/bash

# Paths & Connectivity
SPARK_KUBE_CONF="$HOME/qn/area/work/frt/frt-projects/spark-k8s-dev/secrets/k8s_dev_conf.txt"
REMOTE_HOST="spark-master-dev-k8s"

# Credentials
FRT_AWS_KEY="XXXX"
FRT_AWS_SECRET="YYYY"
FRT_AWS_REGION="us-east-1"
KERNEL_ENV="LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
AWS_ACCESS_KEY_ID='${FRT_AWS_KEY}' \
AWS_REGION='${FRT_AWS_REGION}' \
AWS_SECRET_ACCESS_KEY='${FRT_AWS_SECRET}'"

frt_forward_spark_notebook() {
    if [[ ! -f "$SPARK_KUBE_CONF" ]]; then
        echo "Error: Kube config not found at $SPARK_KUBE_CONF"
        return 1
    fi

    export KUBECONFIG="$SPARK_KUBE_CONF"
    echo "Setting context to spark-operator..."
    kubectl config set-context --current --namespace=spark-operator

    echo "Forwarding port 30004 -> 22..."
    kubectl port-forward service/spark-cluster-master-nodeports 30004:22
}

# -- Kernels --

### Usage: frt_add_scala_kernel quocnhv 4 2 2g
frt_add_scala_kernel() {
    local USER=${1:-quocnhv}
    local T_CORES=${2:-2}
    local E_CORES=${3:-2}
    local MEM=${4:-6g}

    echo "Adding SCALA kernel for $USER (Cores: $T_CORES, Mem: $MEM)..."

    local CMD="SPARK_OPTS=' \
        --name=${USER} \
        --total-executor-cores=${T_CORES} \
        --executor-cores=${E_CORES} \
        --executor-memory=${MEM} ' \
        ${KERNEL_ENV} \
        /usr/local/share/jupyter/kernels/apache_toree_scala/bin/run.sh --profile {connection_file}"

    remote_ikernel manage --add \
        --name="scala-${USER}" \
        --interface=ssh \
        --host="${REMOTE_HOST}" \
        --workdir='/' \
        --language=scala \
        --kernel_cmd="$CMD"
}

### Usage: frt_add_pyspark_kernel quocnhv 4 2 2g
frt_add_pyspark_kernel() {
    local USER=${1:-quocnhv}
    local T_CORES=${2:-2}
    local E_CORES=${3:-2}
    local MEM=${4:-6g}

    echo "Adding PySpark kernel for $USER (Cores: $T_CORES, Mem: $MEM)..."

    # PySpark paths
    local SPARK_HOME="/opt/bitnami/spark"
    local PY_PATH="${SPARK_HOME}/python/:${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip"

    local CMD="${KERNEL_ENV} \
        SPARK_HOME=${SPARK_HOME} \
        PYTHONPATH='${PY_PATH}' \
        PYTHONSTARTUP=${SPARK_HOME}/python/pyspark/shell.py \
        PYSPARK_SUBMIT_ARGS=' \
          --name=${USER} \
          --total-executor-cores=${T_CORES} \
          --executor-cores=${E_CORES} \
          --executor-memory=${MEM} pyspark-shell ' \
        python -m ipykernel_launcher -f {connection_file}"

    remote_ikernel manage --add \
        --name="pyspark-${USER}" \
        --interface=ssh \
        --host="${REMOTE_HOST}" \
        --workdir='/' \
        --language=python \
        --kernel_cmd="$CMD"
}

### Usage: frt_delete_kernel rik_ssh_spark_master_dev_k8s_scala
### Usage: frt_delete_kernel rik_ssh_spark_master_dev_k8s_pyspark
frt_delete_kernel() {
    if [ -z "$1" ]; then
        echo "Usage: frt_delete_kernel <kernel_name>"
        return 1
    fi
    echo "Deleting kernel: $1"
    remote_ikernel manage --delete "$1"
}

### Usage: frt_list_kernels
frt_list_kernels() {
    echo "Available Kernels:"
    jupyter kernelspec list
}
