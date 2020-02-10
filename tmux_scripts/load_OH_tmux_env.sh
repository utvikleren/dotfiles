# creates a new tmux window for developing offer_hub
# desired layout has 4 panes: 
# top left (0): vim (in ~/dpn_repos/offer_hub)
# top right (2): local terminal (in ~/dpn_repos/offer_hub)
# bottom left (1): logged into dev server (for running the server)
# bottom right (3): logged into dev server (for running tests)
tmux new-window -n 'OH' -c '/home/msteen/dpn_repos/offer_hub' # pane 0
tmux send-keys 'vim' Enter
tmux split-window -h -c '/home/msteen/dpn_repos/offer_hub' # pane 1
tmux split-window # pane 3
tmux send-keys "sshoh; /bin/bash'" Enter
tmux select-pane -L # back to pane 1
tmux split-window # pane 2
tmux send-keys 'roh' Enter
tmux select-pane -U # back to pane 0
