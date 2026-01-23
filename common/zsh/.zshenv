PC_TYPE_FILE="$HOME/.zsh_pc_type"
OS_FILE="$HOME/.zsh_os"
OS_VERSION_FILE="$HOME/.zsh_os_version"
ARCH_FILE="$HOME/.zsh_arch"

if [[ -f "$PC_TYPE_FILE" ]]; then
    PC_TYPE="$(cat "$PC_TYPE_FILE")"
fi

if [[ -f "$OS_FILE" ]]; then
    OS="$(cat "$OS_FILE")"
fi

if [[ -f "$OS_VERSION_FILE" ]]; then
    OS_VERSION="$(cat "$OS_VERSION_FILE")"
fi

if [[ -f "$ARCH_FILE" ]]; then
    ARCH="$(cat "$ARCH_FILE")"
fi

export PC_TYPE
export OS
export OS_VERSION
export ARCH
