# creates a new tmux window for developing inmar_m2m_auth
# desired layout has 4 panes: 
# top left (0): vim (in ~/dpn_repos/inmar_m2m_auth)
# top right (2): local terminal (in ~/dpn_repos/inmar_m2m_auth)
# bottom left (1): logged into dev server (for running the server)
# bottom right (3): logged into dev server (for running tests)
tmux new-window -n 'm2m' # pane 0
tmux send-keys 'wm; vim' Enter
tmux split-window -h # pane 1
tmux send-keys 'wm' Enter
