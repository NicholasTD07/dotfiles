; package.el

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; Bootstrap use-package

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

; Always install all the packages
(setq use-package-always-ensure t)

; Use :diminish with use-package
; to remove/abbreviate a mode indicator in the modeline
(require 'diminish)
; Use :bind-key with use-package
; to bind keys easily in a tidy way
(require 'bind-key)

; packages.el

; Functionality
(use-package guide-key
  :diminish guide-key-mode
  :config
  (setq guide-key/guide-key-sequence t) ; Enable guide-key for all key sequences
  (guide-key-mode)) ; Enable guide-key-mode

; UI
; (use-package solarized-theme)
;   :config (load-theme 'solarized-dark t))
