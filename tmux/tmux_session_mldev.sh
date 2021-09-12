tmux new -s mldev\; \
  rename-window term \; \
  new-window -n ipy \; \
  send-keys 'ipython' C-m \; \
  new-window -n jupy \; \
  send-keys 'jupyter lab' C-m \; \
  new-window -n htop \; \
  send-keys 'htop' C-m \; \
