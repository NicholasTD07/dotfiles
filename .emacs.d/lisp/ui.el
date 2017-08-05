(use-package whitespace ; Built-in
  :diminish (whitespace-mode global-whitespace-mode)
  :init (setq whitespace-style '(face tabs trailing empty tab-mark))
  :config (global-whitespace-mode))

(use-package time ; Built-in
  :diminish display-time-mode
  :init
  (general-define-key "it" 'display-time-world)
  (setq display-time-world-list '(
                                  ("Australia/Sydney" "Sydney")
                                  ("Asia/Chongqing" "Chongqing")
                                  ("PST8PDT" "San Francisco")
                                  ("Asia/Calcutta" "Bangalore")
                                  ("Australia/Melbourne" "Melbourne")
                                  ("Europe/London" "London")
                                  ("Europe/Paris" "Paris")
                                  ("Asia/Tokyo" "Tokyo")
                                  ("America/Los_Angeles" "Los Angeles")
                                  ("America/New_York" "New York")
                                  ))
  :config (display-time-mode))

(use-package powerline
  :config (powerline-default-theme))

(use-package airline-themes
  :after powerline)
