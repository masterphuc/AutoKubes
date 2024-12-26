# ~/.zshrc.d/autokubes.zsh

# Functions
function k {
  kubectl "$@"
}

function kget {
  kubectl get pods -o wide
}

function kdescribe {
  kubectl describe "$@"
}

function klogs {
  kubectl logs "$@"
}

function kexec {
  kubectl exec "$@"
}

function krun {
  kubectl run "$@"
}

function kapply {
  kubectl apply -f "$@"
}

function kdelete {
  kubectl delete "$@"
}

function kport-forward {
  kubectl port-forward "$@"
}

function kns
{
  kubectl config set-context --current --namespace="$@"
}


# Aliases
alias kg='k get'
alias kd='k describe'
alias kl='k logs'
alias ke='k exec'
alias kr='k run'
alias ka='k apply'
alias kk='k delete'
alias kp='kport-forward'


# Load subcommands from an external file
autoload -U compinit
compinit

_load_subcommands() {
  local -a subcommands
  local file="${PWD}/kube_subcommands"

  if [[ -f "$file" ]]; then
    IFS=$'\n' read -r -d '' -a subcommands <"$file"
  fi
  compgen -W "${subcommands[*]}" --
}

# Autocompletion
_kube_autocomplete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [[ $prev == "k" || $prev == "kubectl" ]]; then
    _load_subcommands
  fi
}

compctl -K _kube_autocomplete k kubectl