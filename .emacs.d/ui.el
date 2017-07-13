(setq
  ring-bell-function #'ignore
  inhibit-startup-screen t ; Skip the startup screen
  initial-scratch-message "Hello there!\n")

(fset 'yes-or-no-p #'y-or-n-p) ; Change yes/no -> y/n
(fset 'display-startup-echo-area-message #'ignore) ; No more startup message

(menu-bar-mode -1) ; Hide menu bar at top