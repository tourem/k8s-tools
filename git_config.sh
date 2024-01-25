[user]
	email = mahamadou.toure@larbotech.com
	name = Mahamadou TOURE
	password = xxxxxxxxxxxx
[core]
	autocrlf = input
[alias]
    amend = commit --amend
    st = status
    who = shortlog -sne
    oneline = log --pretty=oneline --abbrev-commit --graph
    changes = diff --name-status
    dic = diff --cached
    diffstat = diff --stat
    svnpull = svn rebase
    svnpush = svn dcommit
    lc = !git oneline ORIG_HEAD.. --stat --no-merges
    addm = !git-ls-files -m -z | xargs -0 git-add && git status
    addu = !git-ls-files -o --exclude-standard -z | xargs -0 git-add && git status
    rmm = !git ls-files -d -z | xargs -0 git-rm && git status
    mate = !git-ls-files -m -z | xargs -0 mate
    mateall = !git-ls-files -m -o --exclude-standard -z | xargs -0 mate
    st = status
    df = diff
    co = checkout
    ci = commit
    br = branch
    undo = reset --soft HEAD^
    amend = commit --amend
    empiler = stash
    depiler = stash pop
    soft-annuler = reset --soft HEAD~1
    hard-annuler = reset --hard HEAD~1
    update = pull --rebase
	lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>;%Creset' --abbrev-commit"
[push]
	default = current
[http]
	sslVerify = false
