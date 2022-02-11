# kube-ps1.sh from https://github.com/jonmosco/kube-ps1
source kube-ps1.sh
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] \t`if [ $? = 0 ]; then echo " $(kube_ps1)\[\033[01;32m\] ✔"; else echo " $(kube_ps1)\[\033[01;31m\] ✘"; fi`$(__git_ps1) '$'\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
