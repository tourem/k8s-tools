
# Homebrew shellenv
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export HOME=/Users/mtoure
export PATH=$HOME/install/bin:$PATH

source git-prompt.sh

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] \t`if [ $? = 0 ]; then echo "\[\033[01;32m\] ✔"; else echo "\[\033[01;31m\] ✘"; fi`$(__git_ps1) '$'\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '

jdk() {
      version=$1
      unset JAVA_HOME;
      export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
      java -version
}

alias k="kubecolor"


#alias k='kubectl'

#complete -F __start_kubectl k

 # Get current context
alias krc='kubectl config current-context'
# List all contexts
alias klc='kubectl config get-contexts -o name | sed "s/^/  /;\|^  $(krc)$|s/ /*/"'
# Get current namespace
alias krn='kubectl config get-contexts --no-headers "$(krc)" | awk "{print \$5}" | sed "s/^$/default/"'
alias kcns='kubectl config set-context --current --namespace=ns005i000200'

alias kg='kubectl get '

alias kgnw='kubectl get nodes -o wide'
alias kgnl='kubectl get nodes --show-labels'

alias kgno='kubectl get nodes'
alias kgpo='kubectl get pods'
alias kgsvc='kubectl get svc'
alias kging='kubectl get ingress'
alias kgdeploy='kubectl get deployments'
alias kgcm='kubectl get configmap'
alias kgsec='kubectl get secret'
alias kdpoall='kubectl get pods --all-namespaces'
alias kgposl='kubectl get pods --show-labels'

alias kdno='kubectl describe nodes'
alias kdpo='kubectl describe pods'
alias kdsvc='kubectl describe svc'
alias kding='kubectl describe ingress'
alias kddeploy='kubectl describe deployments'
alias kdcm='kubectl describe configmap'
alias kdsec='kubectl describe secret'



alias kcf='kubectl create -f '
alias krm='kubectl delete '
alias krmf='kubectl delete -f '
alias kaf='kubectl apply -f '

alias k8sd='octant'
alias kaf='kubectl apply -f '

#source <(kubectl completion bash)
source <(helm completion bash)

function ktd () { 
	/Users/mtoure/k3d/startK3dCluster.sh ; 
    source /Users/mtoure/.kube-ps1.sh ;
    export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] \t`if [ $? = 0 ]; then echo " $(kube_ps1)\[\033[01;32m\] ✔"; else echo " $(kube_ps1)\[\033[01;31m\] ✘"; fi`$(__git_ps1) '$'\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] ' ;}

export NO_PROXY=kubernetes.docker.internal

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

source <(kubectl completion bash)

complete -F __start_kubectl k

if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh
fi

alias sktd='k3d cluster stop devcluster; k3d cluster delete devcluster'

