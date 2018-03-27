;;; keybindings.el --- Spacemacs Layer Key Bindings File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Use ido for find-file, helm for everything else.
(spacemacs/set-leader-keys "ff" #'ido-find-file)
(global-set-key (kbd "C-x C-f") #'ido-find-file)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x b") #'helm-mini)
