#!/bin/bash

session="monitor"

exist=$(tmux list-session 2>/dev/null | grep $session | wc -l)

if [ "$exist" -eq "0" ]; then

    tmux start-server #there's no harm in calling to start a tmux server when it's already running
    tmux new-session -d -s $session
    tmux selectp -t 1
    tmux send-keys "htop" C-m
    tmux splitw -h
    tmux selectp -t 2
    tmux splitw -v
    tmux selectp -t 3
    tmux send-keys "nload" C-m
    tmux splitw -v
    tmux selectp -t 4
    tmux send-keys "watch -n 1800 df -h /" C-m

fi


tmux attach-session -t $session

