#!/bin/bash

# Linux
if [[ "$OS" == "ubuntu" || "$OS" == "arch" ]]; then
    # Neovim
    if [[ "$ARCH" == "amd64" && -d "/opt/nvim/nvim-linux-x86_64/bin" ]]; then
        export PATH="$PATH:/opt/nvim/nvim-linux-x86_64/bin"
    fi

    # Cargo
    export PATH="$HOME/.cargo/bin:$PATH"

    # Coursier
    export PATH="$PATH:$HOME/.local/share/coursier/bin"
elif [[ "$OS" == "macos" ]]; then
    # Antigravity
    export PATH="$PATH:$HOME/.antigravity/antigravity/bin"

    # Coursier
    export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
fi

# # JVM (via Coursier)
# cs java --jvm temurin:17 --env

# Python
PYTHON_DEFAULT_VER="3.12"
function create_virtual_python_environment() {
    local use_uv="$1"

    if [[ "$use_uv" == "uv" ]]; then
        echo "Initializing project with 'uv' (Python $PYTHON_DEFAULT_VER)..."
        uv init -p "$PYTHON_DEFAULT_VER"
        uv venv -p "$PYTHON_DEFAULT_VER"
        uv sync
        uv add pip

        # Activate
        source .venv/bin/activate
        echo "uv environment created and activated."
    else 
        echo "Creating standard 'venv' (Python $PYTHON_DEFAULT_VER)..."
        "python${PYTHON_DEFAULT_VER}" -m venv .venv

        # Activate & Update
        source .venv/bin/activate
        pip install --upgrade pip
        echo "venv environment created and activated."
    fi
}
alias cpyv="create_virtual_python_environment"  # Create (usage: cpyv or cpyv uv)
alias apyv="source ./.venv/bin/activate"        # Activate
alias dpyv="deactivate"                         # Deactivate

# Docker
alias dkc-stop='docker stop $(docker ps -aq)'
alias dkc-rm='docker rm $(docker ps -aq)'
alias dkv-prune='docker volume prune -f'

# Kubernetes
alias k='kubectl'
alias kc='kubectl-convert'
alias kind='kind'
alias mkb='minikube'

# # Lệnh 1: Chọn Pod và xem Log (không cần nhớ tên)
# kl() {
#     local pod=$(kubectl get pods --all-namespaces | fzf --header-lines=1 | awk '{print $2}')
#     local ns=$(kubectl get pods --all-namespaces | grep "$pod" | awk '{print $1}')
#     [ -n "$pod" ] && kubectl logs -f "$pod" -n "$ns"
# }
# 
# # Lệnh 2: Chọn Pod và chui vào Shell (siêu nhanh)
# kx() {
#     local pod=$(kubectl get pods --all-namespaces | fzf --header-lines=1 | awk '{print $2}')
#     local ns=$(kubectl get pods --all-namespaces | grep "$pod" | awk '{print $1}')
#     [ -n "$pod" ] && kubectl exec -it "$pod" -n "$ns" -- /bin/bash
# }
# 
# # Lệnh 3: Xóa nhanh các Pod bị lỗi (Evicted/Error)
# kclean() {
#     kubectl get pods --all-namespaces | grep -E 'Evicted|Error|Completed' | awk '{print $2 " --namespace " $1}' | xargs -L1 kubectl delete pod
# }
# 
# # User Case: "Soi" tài nguyên GPU của từng Pod
# kgpu() {
#     kubectl get pods --all-namespaces -o json | jq -r '.items[] | select(.spec.containers[].resources.limits."nvidia.com/gpu" != null) | [.metadata.namespace, .metadata.name, .spec.containers[].resources.limits."nvidia.com/gpu"] | @tsv' | column -t | fzf --header "NAMESPACE NAME GPUS"
# }
# 
# # User Case: Truy cập nhanh Dashboard (Port-forwarding)
# kpf() {
#     local svc=$(kubectl get svc --all-namespaces | fzf --header-lines=1 --prompt="Chọn Service để Port-Forward: ")
#     [ -z "$svc" ] && return
#     local ns=$(echo $svc | awk '{print $1}')
#     local name=$(echo $svc | awk '{print $2}')
#     local port=$(echo $svc | awk '{print $5}' | cut -d'/' -f1 | cut -d':' -f1)
#     
#     echo "Forwarding $name ($ns) to http://localhost:8080..."
#     kubectl port-forward -n $ns svc/$name 8080:$port
# }
# 
# # 3. User Case: Theo dõi log của Training Job theo "Real-time"
# kjlog() {
#     local pod=$(kubectl get pods --sort-by=.metadata.creationTimestamp | grep -E "train|job|worker" | tail -n 20 | fzf --tac --header "Chọn Pod mới nhất để xem log:")
#     [ -z "$pod" ] && return
#     kubectl logs -f $(echo $pod | awk '{print $1}')
# }
# 
# # User Case: Copy File nhanh từ Pod về Local (và ngược lại)
# kcp() {
#     local pod=$(kubectl get pods | fzf --header-lines=1 | awk '{print $1}')
#     [ -z "$pod" ] && return
#     read "src?Nhập đường dẫn file nguồn (vd: /tmp/model.pth): "
#     read "dest?Nhập đường dẫn đích (vd: ./model.pth): "
#   
#     # Nếu có dấu ':' thì hiểu là từ Pod về Local
#     if [[ $src == ":"* ]]; then
#         kubectl cp ${pod}${src} $dest
#     else
#         kubectl cp $src ${pod}:${dest}
#     fi
# }
# 
# # 5. User Case: Chuyển đổi nhanh giữa các "Kubeconfig" khác nhau
# kcfg() {
#     local cfg=$(find ~/.kube -type f | fzf --prompt="Chọn Kubeconfig: ")
#     [ -z "$cfg" ] && return
#     export KUBECONFIG=$cfg
#     echo "Đã chuyển sang config: $KUBECONFIG"
#     # Update tmux bar nếu có
#     tmux set-environment KUBECONFIG $KUBECONFIG 2>/dev/null
# }
# 
# # 6. Mẹo: Kết hợp với kubecolor và bat
# # Cách dùng: kyaml pod my-pod
# kyaml() {
#     kubectl get "$@" -o yaml | bat -l yaml
# }
