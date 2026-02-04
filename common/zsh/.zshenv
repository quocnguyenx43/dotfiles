OS_FILE="$HOME/.zsh_os"
OS_VERSION_FILE="$HOME/.zsh_os_version"
ARCH_FILE="$HOME/.zsh_arch"

if [[ -f "$OS_FILE" ]]; then
    OS="$(cat "$OS_FILE")"
fi

if [[ -f "$OS_VERSION_FILE" ]]; then
    OS_VERSION="$(cat "$OS_VERSION_FILE")"
fi

if [[ -f "$ARCH_FILE" ]]; then
    ARCH="$(cat "$ARCH_FILE")"
fi

export OS
export OS_VERSION
export ARCH
