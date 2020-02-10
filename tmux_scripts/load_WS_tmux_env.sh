# creates a new tmux window for developing web services
# desired layout has 4 panes: 
# top left (0): vim (in ~/dpn_repos/dpn_web_services)
# top right (2): local terminal (in ~/dpn_repos/dpn_web_services)
# bottom left (1): logged into dev server (for running the server)
# bottom right (3): logged into dev server (for running tests)
tmux new-window -n 'WS' -c '/home/msteen/dpn_repos/dpn_web_services' # pane 0
tmux send-keys 'vim' Enter
tmux split-window -h -c '/home/msteen/dpn_repos/dpn_web_services' # pane 1
tmux split-window # pane 3
tmux send-keys "sshws; /bin/bash'" Enter
tmux select-pane -L # back to pane 1
tmux split-window # pane 2
tmux send-keys "rws" Enter
tmux select-pane -U # back to pane 0
