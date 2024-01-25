
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

===================================================================================

export HOME=/c/Users/d40779

export JBANG_DEFAULT_JAVA_VERSION=8
export JBANG_REPO=/c/Work/repos/maven
export MAVEN_OPTS='-Dhttps.proxyHost=vip-svc-campus-prx.fr.xcp.net.intra -Dhttps.proxyPort=8080 -Dhttps.proxyUser=d40779 -Dhttps.proxyPassword=Libra1906_'
#export MAVEN_OPTS='-Dhttps.proxyHost=vip-pxp1vau-std.fr.net.intra -Dhttps.proxyPort=3132 -Dhttps.proxyUser=d40779 -Dhttps.proxyPassword=Libra1906_'

source /c/Users/d40779/git-prompt.sh

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] \t`if [ $? = 0 ]; then echo "\[\033[01;32m\] ✔"; else echo "\[\033[01;31m\] ✘"; fi`$(__git_ps1) '$'\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '

export https_proxy=http://d40779:Libra1906_@ncproxy:8080
export http_proxy=http://d40779:Libra1906_@ncproxy:8080



export NODE_HOME=/c/Users/d40779/install/tools-master/node-v14.16.0-win-x64
export PATH=${NODE_HOME}:$PATH
export SONAR_SCANNER_HOME=/c/Users/d40779/install/sonar-scanner-4.3.0.2102-windows
export PATH=${SONAR_SCANNER_HOME}/bin:$PATH
#export M2_HOME=/c/Work/tools/apps/apache-maven-3.5.3
export M2_HOME=/c/Work/tools/apps/apache-maven-3.6.2
export PATH=${M2_HOME}/bin:$PATH
export INSTALL_BIN=/c/Users/d40779/install
export PATH=${INSTALL_BIN}/bin:${INSTALL_BIN}/IBM_Cloud_CLI:$PATH
export PATH=${INSTALL_BIN}/sbt/bin:$PATH
export CHROME=/c/Users/d40779/AppData/Local/Google/Chrome/Application
export PATH=${CHROME}:$PATH
export MVND_HOME=/c/Users/d40779/install/mvnd
export PATH=${MVND_HOME}/bin:$PATH

export JAVA_HOME=/c/Work/tools/apps/oracle-jdk-1.8u161-x64
export PATH=${JAVA_HOME}/bin:$PATH

alias jdk8='export JAVA_HOME=/c/Users/d40779/install/jdk1.8.0_392; export PATH=${JAVA_HOME}/bin:$PATH'
alias jdk11='export JAVA_HOME=/c/Users/d40779/install/jdk-11.0.21; export PATH=${JAVA_HOME}/bin:$PATH'
alias jdk17='export JAVA_HOME=/c/Users/d40779/install/jdk-17.0.9; export PATH=${JAVA_HOME}/bin:$PATH'
alias jdk21='export JAVA_HOME=/c/Users/d40779/install/jdk-21.0.1; export PATH=${JAVA_HOME}/bin:$PATH'

alias mvn='mvn -Dmaven.wagon.http.ssl.insecure=true'
alias mvnc='mvn dependency-check:check -Dmaven.wagon.http.ssl.insecure=true'
alias mvni='mvn clean install -Dmaven.wagon.http.ssl.insecure=true'
alias mvns='mvn clean install -DskipTests -Dmaven.wagon.http.ssl.insecure=true'
alias mvnt='mvn dependency:tree -Dmaven.wagon.http.ssl.insecure=true'


alias k='kubectl'

complete -F __start_kubectl k
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

alias kaf='kubectl apply -f '
alias kl='kubectl config use-context docker-desktop ; source /c/Users/d40779/prompt-git-k8s.sh'
alias kc='kubectl config use-context ku002i000250/c3k551rb0j3ihnekcjr0 ; source /c/Users/d40779/prompt-git-k8s.sh'

source ~/bash_completion.d/kubectl
source ~/bash_completion.d/git-completion.sh

#source <(kubectl completion bash)
source <(helm completion bash)
 
function jq(){
  jq.exe -C "$@" | tr -d '\r'
}

function pv4 () { /c/Users/d40779/dmzr/dmzr-system-team.sh "$1" ; source /c/Users/d40779/prompt-git-k8s.sh ;}

export NO_PROXY=kubernetes.docker.internal

#export https_proxy=http://d40779:Libra1906_@vip-pxp1vau-std.fr.net.intra:3132
#export http_proxy=http://d40779:Libra1906_@vip-pxp1vau-std.fr.net.intra:3132
source <(kubectl completion bash)




