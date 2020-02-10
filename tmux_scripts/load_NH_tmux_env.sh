# creates a new tmux window for developing hub_inbound_notifications
# desired layout has 4 panes: 
# top left (0): vim (in ~/dpn_repos/hub_inbound_notifications)
# top right (2): local terminal (in ~/dpn_repos/hub_inbound_notifications)
# bottom left (1): logged into dev server (for running the server)
# bottom right (3): logged into dev server (for running tests)
tmux new-window -n 'NH' -c '/home/msteen/dpn_repos/hub_inbound_notifications' # pane 0
tmux send-keys 'vim' Enter
tmux split-window -h -c '/home/msteen/dpn_repos/hub_inbound_notifications' # pane 1
tmux split-window # pane 3
tmux send-keys "sshnh; /bin/bash'" Enter
tmux select-pane -L # back to pane 1
tmux split-window # pane 2
tmux send-keys 'rnh' Enter
tmux select-pane -U # back to pane 0
