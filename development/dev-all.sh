#!/bin/bash

# Default app name, can be overridden with first argument
APP_NAME=${1:-kta_employee}

# Create tmux session and open 3 windows
tmux new-session -d -s frappe-dev

# Window 0: Frappe Backend
tmux rename-window -t frappe-dev:0 'Backend'
tmux send-keys -t frappe-dev:0 'bench start' C-m

# Window 1: Frontend
tmux new-window -t frappe-dev:1 -n 'Frontend'
tmux send-keys -t frappe-dev:1 "cd apps/$APP_NAME/frontend && yarn dev" C-m

# Window 2: Shell
tmux new-window -t frappe-dev:2 -n 'Shell'

# Attach to session
tmux attach-session -t frappe-dev
