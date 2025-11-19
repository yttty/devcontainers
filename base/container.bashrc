export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export PATH=$HOME/.local/bin:$HOME/.local/share/diff-so-fancy:$PATH

################# alias for system utilities #################
alias l='ls -lAh'
alias cls='clear'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias df='df -h'

################# Git bash config #################
# Git completion and prompt
source ~/.local/share/git-core/contrib/completion/git-completion.bash
source ~/.local/share/git-core/contrib/completion/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUPSTREAM="auto"
export PS1='\n\[\033[01;34m\]#\[\033[00m\] \[\033[36m\]\u\[\033[00m\] @ \[\033[32m\]\h\[\033[00m\] in \[\033[34m\]\w\[\033[00m\]$(__git_ps1 " \[\033[33m\](%s)\[\033[00m\]") [\D{%H:%M:%S}] \n\[\033[31m\]\$\[\033[00m\] '

# alias for git
gclb() { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done; }
gcmu() { git commit -m "chore: update"; }
gce() { git credential-cache exit; }
gaa() { git add --all; }
gd() { git diff; }
gdc() { git diff --cached; }
ggraph() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative; }
gfind() { git log --grep $1; } # Grep in commit message
ghist() { git log -p -M --follow --stat $1; } # History of a file
glp() { git log -p $1; }
gll() { git log --stat; }
gsha() { git rev-parse HEAD; }
gst() { git status; }
gtop() { git log --stat -n 1; }
gb() { git branch; }
gba() { git branch --all; }
gbd() { git branch --delete $1; }
alias g='git'
alias gg='ggraph'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcbd='git checkout -b dev'
alias gcd='git checkout dev'
alias gcB='git checkout -B'
alias gcm='git checkout main'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
alias gcmm='git commit -m'
alias gp='git push'
alias gpu='git pull'
alias gl='git log'
