#!/bin/bash
# Usage                        : spawn-producers.sh <KAFKA_BROKER_HOST>:9092 <NUM_SPAWNS> <SESSION_NAME>
# Example                      : spawn-producers.sh 52.26.67.30:9092 8 k1
# View sessions                : tmux ls
# New session.                 : tmux new -s <SESSION_NAME>
# Attach to session            : tmux a -t <SESSION_NAME>:<WINDOW>
# Example                      : tmux a -t k1
# Kill all producers in session: tmux kill-session -t <SESSION_NAME>
# Kill tmux and all sessions.  : tmux kill-server

# Keyboard commands
# Ctrl-b n    moves to the next window indicated by an * sign on the bottom
# Ctrl-b p    moves to the previous window indicated by an * sign on the bottom
# Ctrl-b d    detach from session
#
#

HOST=$1
NUM_SPAWNS=$2
SESSION_NAME=$3
tmux new -s $SESSION_NAME -n bash -d
for ID in `seq 1 $NUM_SPAWNS`;
do
    echo $ID
    tmux new-window -t $ID
    tmux send-keys -t $SESSION_NAME:$ID 'python3 producer.py '"$HOST"'' C-m
done