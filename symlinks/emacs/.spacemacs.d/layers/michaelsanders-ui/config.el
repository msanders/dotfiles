;;; config.el --- Spacemacs Layer Config File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Make tooltips appear in echo area.
(tooltip-mode -1)

;; Disable bold fonts.
(set-face-bold-p 'bold nil)

;; Open new files in same frame on Mac.
(setq ns-pop-up-frames nil)

(setq neo-show-hidden-files nil)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq default-frame-alist '(
                            (ns-transparent-titlebar . t)
                            (ns-appearance . 'nil)
                            ))
(setq-default git-magit-status-fullscreen t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq delete-by-moving-to-trash t)
(setq display-time-24hr-format t)
(setq font-lock-maximum-decoration t)
(setq trash-directory "~/.Trash")
(display-time-mode)

;; Workaround for https://github.com/syl20bnr/spacemacs/issues/5435.
;; https://github.com/syl20bnr/spacemacs/issues/5435#issuecomment-195862080
(add-hook 'spacemacs-buffer-mode-hook
          (lambda ()
            (set (make-local-variable 'mouse-1-click-follows-link) nil)))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; Fill column indicator settings.
(add-hook 'c-mode-hook #'80-column-rule)
(add-hook 'cc-mode-hook #'80-column-rule)
(add-hook 'c++-mode-hook #'80-column-rule)
(add-hook 'elm-mode-hook #'80-column-rule)
(add-hook 'emacs-lisp-mode-hook #'80-column-rule)
(add-hook 'haskell-mode-hook #'100-column-rule)
(add-hook 'js2-mode-hook #'100-column-rule)
(add-hook 'lisp-mode-hook #'80-column-rule)
(add-hook 'markdown-mode-hook #'80-column-rule)
(add-hook 'python-mode-hook #'80-column-rule)
(add-hook 'rust-mode-hook #'100-column-rule)
(add-hook 'ruby-mode-hook #'120-column-rule)
(add-hook 'scheme-mode-hook #'80-column-rule)
(add-hook 'sh-mode-hook #'80-column-rule)
(add-hook 'swift-mode-hook #'120-column-rule)
(add-hook 'text-mode-hook #'80-column-rule)

;; Helm dash hooks.
(add-hook 'c-mode-hook
          (lambda () (setq-local helm-dash-docsets '("C"))))
(add-hook 'cc-mode-hook
          (lambda () (setq-local helm-dash-docsets '("C++"))))
(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Emacs Lisp"))))
(add-hook 'haskell-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Haskell"))))
(add-hook 'js2-mode-hook
          (lambda () (setq-local helm-dash-docsets '("JavaScript"))))
(add-hook 'lisp-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Common Lisp"))))
(add-hook 'python-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Python 2" "Python 3"))))
(add-hook 'rust-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Rust"))))
(add-hook 'ruby-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Ruby"))))
(add-hook 'swift-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Swift"))))
