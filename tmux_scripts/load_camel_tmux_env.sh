# creates a new tmux window for developing camel
# desired layout has 4 panes: 
# top left (0): vim (in ~/dpn_repos/camel)
# top right (2): local terminal (in ~/dpn_repos/camel)
# bottom left (1): logged into dev server (for running the server)
# bottom right (3): logged into dev server (for running tests)
tmux new-window -n 'camel' -c '/home/msteen/dpn_repos/dpn_camel' # pane 0
tmux send-keys 'vim' Enter
tmux split-window -h -c '/home/msteen/dpn_repos/dpn_camel' # pane 1
tmux split-window # pane 3
tmux send-keys 'sshd' Enter
tmux select-pane -L # back to pane 1
tmux split-window # pane 2
tmux send-keys 'sshd' Enter
