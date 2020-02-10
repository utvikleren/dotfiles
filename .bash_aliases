# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# custom aliases


# system commands
alias ls='ls --color=auto'
alias gr='grep -r'
alias head='head -n 50'
alias vim='nvim'
alias vi='vim'

# misc other aliases
alias alh='alembic history | head -n 10'
alias kubectl='microk8s.kubectl'
alias clam='sudo echo '\''Performing system scan...'\''; sudo clamscan --max-filesize=3999M --max-scansize=3999M --exclude-dir=/sys/* -i -r /'
alias update-all='sudo apt update; sudo apt upgrade -y; sudo apt autoremove'

alias vsc='vim ~/.ssh/config'
alias vb='vim ~/.bashrc'
alias vba='vim ~/.bash_aliases'
alias sb='source ~/.bashrc'


# git aliases
alias gc='git checkout'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcd='git checkout -'
alias gcnb='git checkout master; git pull; git checkout '
alias gdgt='git diff | grep -v "^-" | grep TODO'
alias glh='git log | head'
alias glvh='git log --name-only | head'
alias gpo='git push origin +HEAD'
alias gprc='git checkout $ws_rc; git pull'
alias gprcnh='git checkout $nh_rc; git pull'
alias gprcoh='git checkout $oh_rc; git pull'
alias grbrc='gprc; gcd; grrc'
alias grbrci='gprc; gcd; grrci'
alias grbrcnh='gprcnh; gcd; grrcnh'
alias grbrcoh='gprcoh; gcd; grrcoh'
alias grc='git rebase --continue'
alias grrc='git rebase $ws_rc'
alias grrci='git rebase $ws_rc --interactive'
alias grrcnh='git rebase $nh_rc'
alias grrcoh='git rebase $oh_rc'
alias gs='git stash'
alias gsl='git stash list'
alias gsp='git stash pop'

# cd aliases
alias cdp='cd ~/dpn_repos'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# qa update aliases
alias cdu='cd ~/dpn_repos/dpn_devtools/developer-contrib/dmasse/'
alias uqa='cdu; fab update_all_qa; cd -'
alias uqaar='cdu; fab update_qa_after_rebase:$ws_rc; cd -'
alias uqadb='cdu; fab update_database -H qa-utility.dev.dpn.inmar.com; cd -'

alias cduoh='cd ~/dpn_repos/dpn_devtools/developer-contrib/msteen/'
alias uqaoh='cduoh; fab update_qa; cd -'
alias uqaohdb='fab update_database; cd -'

# qa ssh aliases
alias sshqaapi='ssh qa-api.dev.dpn.inmar.com'
alias sshqaas='ssh qa-async-std.dev.dpn.inmar.com'
alias sshqaabg='ssh qa-async-bg.dev.dpn.inmar.com'
alias sshqau='ssh qa-utility.dev.dpn.inmar.com'

alias sshqaoh='ssh qa-hub-offer.dev.dpn.inmar.com'
alias sshqanh='ssh qa-hub-inbound.dev.dpn.inmar.com'
alias sshqach='ssh qa-hub-clip.dev.dpn.inmar.com'

# misc ssh aliases
alias ssa='ssh-add /home/msteen/.ssh/inmar/private.pem'
alias sshaws='ssh -i /home/msteen/personal/AWSkey2.pem ubuntu@ec2-52-40-89-141.us-west-2.compute.amazonaws.com'
alias sshb='ssh -fN bastion'
alias sshd='ssh msteen-dev'
alias sshj='ssh msteen@qa-jenkins-master-ws-01.dev.dpn.inmar.com'
alias sshld='ssh msteen@development-msteen-dev.dev.dpn.inmar.com  -L8091:development-msteen-dev.dev.dpn.inmar.com:80'
alias sshlm='ssh msteen@qa-mimic.dev.dpn.inmar.com  -L8090:qa-mimic.dev.dpn.inmar.com:80'

# dev instance aliases
# bash function to start a box, check status until it's ready to accept connections, and then ssh to it
start_and_ssh () 
{ 
    start_command="start$1";
    status_check_command="status$1 | jq \".InstanceStatuses[0].SystemStatus.Status\" | sed 's/\"//g'";
    ssh_command="ssh$1";
    eval $start_command;
    echo "started box. waiting...";
    while [ $(eval $status_check_command) != "ok" ]; do
        sleep 15;
        echo ".";
    done;
    eval $ssh_command
}

alias ssd='start_and_ssh d'
alias startd='aws ec2 start-instances --instance-ids $dev_instance_id'
alias statusd='aws ec2 describe-instance-status --instance-ids $dev_instance_id'
alias stopd='aws ec2 stop-instances --instance-ids $dev_instance_id'

# project-specific aliases

# each projet has an abbreviation; commands with the same purpose follow the same pattern
# cdabbr - cd to the project's working directory
# wabbr - cd to the project diectory and workon the project (enter the venv)
# dabbr - deploy code from the local working directory to the dev server
# sshabbr - ssh with a command. note that this alias is open-ended (doesn't close the single quote) to allow other aliases to add to the command
# rabbr - run the app on the dev server (uses sshabbr)
# tabbr - load tmux config for the project, which usually opens 4 panes - vim in the local project directory, terminal in the project directory, running app, and second window on the server

# WS
alias cdws='cd ~/dpn_repos/dpn_web_services'
alias wws='cdws'
alias dws='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/dpn_web_services msteen-dev:/home/msteen/'
alias sshws="ssh -t msteen-dev 'cd /home/msteen/dpn_web_services; source /inmar/dpn/virtualenv/dpn_web_services/bin/activate; export DJANGO_SETTINGS_MODULE=multidb_piston.settings"
alias rws="sshws; python multidb_piston/manage.py runserver 0.0.0.0:8000'"
alias tws='~/tmux_scripts/load_WS_tmux_env.sh'

alias drr='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/dpn_redemption_rules msteen-dev:/home/msteen/'

# OH
alias cdoh='cd ~/dpn_repos/offer_hub'
alias woh='cdoh'
alias doh='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/offer_hub msteen-dev:/home/msteen/'
alias sshoh="ssh -t msteen-dev 'cd /home/msteen/offer_hub; source /inmar/dpn/virtualenv/offer_hub/bin/activate"
alias roh='sshoh; pserve environments/development.ini --reload'
alias toh='~/tmux_scripts/load_OH_tmux_env.sh'

# NH
alias cdnh='cd ~/dpn_repos/hub_inbound_notifications'
alias wnh='cdnh'
alias dnh='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/hub_inbound_notifications msteen-dev:/home/msteen/'
alias sshnh="ssh -t msteen-dev 'cd /home/msteen/hub_inbound_notifications; source /inmar/dpn/virtualenv/hub_inbound_notifications/bin/activate"
alias rnh='sshnh; python -m notifications.server'
alias tnh='~/tmux_scripts/load_NH_tmux_env.sh'

# CH (incomplete)
alias dch='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/hub_clip_proxy msteen-dev:/home/msteen/'

# camel (incomplete)
alias cdc='cd ~/dpn_repos/dpn_camel'
alias wc='cdc'
alias dc='rsync -avz --exclude *.gz --exclude .git --exclude .idea /home/msteen/dpn_repos/dpn_camel msteen-dev:/home/msteen/'
alias tc='~/tmux_scripts/load_camel_tmux_env.sh'

# m2m (local dev; golang)
alias export_m2m='export DB_USERNAME="oh_admin"; export DB_PASSWORD="offer_spoke"; export DB_HOSTNAME="localhost"'
alias cdm='cd ~/dpn_repos/inmar_m2m_auth'
alias sm='source /home/msteen/virtualenv/m2m/bin/activate'
alias wm='cdm; sm; export_m2m'
alias tm2m='~/tmux_scripts/load_m2m_tmux_env.sh'
