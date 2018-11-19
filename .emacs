(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(elpy-test-discover-runner-command (quote ("python" "-m")))
 '(elpy-test-nose-runner-command
   (quote
    ("nosetests" "-s" "--tc" "environment:qacdn-dev.json")))
 '(elpy-test-runner (quote elpy-test-nose-runner))
 '(magithub-github-hosts (quote ("pdihub.hi.net")))
 '(package-selected-packages
   (quote
    (dashboard sx py-autopep8 smart-mode-line-powerline-theme smart-mode-line flycheck better-defaults centered-cursor-mode powerline elpygen magithub magit elpy)))
 '(sml/theme (quote powerline))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq elpy-rpc-backend "jedi")

(setq elpy-test-nose-runner-command
    '("nosetests" "-s" "--tc" "environment:qacdn-dev.json"))

(setq magithub-clone-default-directory "~/PycharmProjects")

(smart-mode-line-enable)
