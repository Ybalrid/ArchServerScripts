#!/bin/bash

session="monitor"

#todo check if tmux server is already running?

tmux start-server

#todo check if session already exist?
tmux new-session -d -s $session
tmux selectp -t 1
tmux send-keys "htop" C-m
tmux splitw -h
tmux selectp -t 2
tmux splitw -v
tmux selectp -t 3
tmux send-keys "nload" C-m
tmux selectp -t 2

#tmux attach-session -t $session

