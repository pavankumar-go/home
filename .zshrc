# If you come from bash you might have to change your $PATH.
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig/:/usr/local/Cellar/librdkafka/1.6.0/lib/pkgconfig:/usr/local/opt/openssl/lib/pkgconfig
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig/
export PATH=$PATH:${HOME}/.krew/bin
#kubectl
alias k=kubectl

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
#auto-suggestion feature path
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

func kexec() {
kubectl exec -it $1 sh -n $2
}
#prod-DB-port-forward
func pfzion() {
ssh-add ~/.ssh/*.pem
ssh jumpprod -L 127.0.0.1:3306:10.120.95.75:3306 -N
}

func pftrans() {
ssh-add ~/.ssh/*.pem
ssh jumpprod -L 127.0.0.1:3306:172.31.24.153:3306 -N
}

func pfneo() {
ssh-add ~/.ssh/*.pem
ssh jumpprod -L 127.0.0.1:3306:192.168.4.44:3306 -N
}

func pfargus() {
ssh-add ~/.ssh/*.pem
ssh jumpprod -L 127.0.0.1:5432:10.120.37.106:5432 -N
}

#chamber-crap
alias chambertest='aws-vault exec test-ft-encryption -- chamber'
alias chamberprod='aws-vault exec prod-ft-encryption -- chamber'

#docker-compose experimaental
func dc() {
COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose $1 $2
}

#view k8s secret
func view() {
k view-secret $1 -a -n $2
}


#describe pod
func des() {
 k describe po $1 -n $2 | less
}

#get pods by label
function get() {
k get po -l app=$1 --all-namespaces $2
}

#lcrash
function lcrash() {
k get po --all-namespaces | grep "0/1" | grep -v "Completed"
}

#get arm 
function getarm(){
k get po --all-namespaces --sort-by=.metadata.creationTimestamp -l arch=arm
}

# kubectl top
function ktop() {
for po in $(k get po -oname -l $1=$2)
do
	pod=${po#"pod/"}
        kubectl top pod $pod --use-protocol-buffers
done
}

#get image
function getimage() {
k get po $1 -n $2 -oyaml | grep image | less
}

#delete in file

function deleteinfile() {
#!/bin/bash
while IFS= read -r line; do
    
done < "$1"
}
#git shorts
alias gs="git status"
alias gpl="git pull"
alias gca= "git commit --amend"
alias gco="git commit -m $1"
alias gpo="git push origin"
alias ga="git add"
alias k="kubectl"

# terraform aliases
alias tf="terraform fmt"
alias ta="terraform apply -auto-approve"
alias td="terraform destroy -auto-approve"
alias tp="terraform plan"


function kns(){
if [ -z "$1" ];then
	kubectl get ns
elif [ ! -z "$1" ]; then 
	kubectl config set-context --current --namespace=$1
fi
}

function kapply(){
k apply -n apps -f $1
}
function eks(){
if [ -z "$1" ];then
      kubectl config current-context
elif [ ! -z "$1" ]; then 
      aws eks --region ap-south-1 update-kubeconfig --name=$1
fi
}

ZSH_DISABLE_COMPFIX="true"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=’red’
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{blue}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
# Path to your oh-my-zsh installation.
export ZSH="/Users/pavan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dogenpunk"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
    	zsh-autosuggestions
	)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;orange;brightness;33\a"
export PATH="/usr/local/opt/libpq/bin:$PATH"
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export PATH="/usr/local/opt/libarchive/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pavan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pavan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pavan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pavan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
if [ -e /Users/pavan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/pavan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
