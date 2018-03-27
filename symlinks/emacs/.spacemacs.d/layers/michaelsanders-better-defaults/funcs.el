;;; funcs.el --- Spacemacs Layer Functions File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; From https://www.emacswiki.org/emacs/BackwardKillLine
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun yank-right ()
  "Move forward one character and yank."
  (interactive)
  (forward-char)
  (yank))

(defun insert-semicolon-end-of-line ()
  "Insert a semicolon at the end of the current line."
  (interactive)
  (end-of-line)
  (insert ";"))

;; Hack from https://github.com/syl20bnr/spacemacs/issues/2751#issuecomment-290739613
;; to hide .DS_Store even when showing hidden files.
(with-eval-after-load 'neotree
  (add-to-list 'neo-hidden-regexp-list "TAGS$")
  (add-to-list 'neo-hidden-regexp-list "__pycache__")

  ;; Patched to allow everything but .DS_Store.
  ;; This must be run after neotree loads in order to monkeypatch.
  (defun neo-util--walk-dir (path)
    "Return the subdirectories and subfiles of the PATH."
    (let* ((full-path (neo-path--file-truename path)))
      (condition-case nil
          (directory-files
           path 'full "^\\([^.]\\|\\.[^D.][^S]\\).*")
        ('file-error
         (message "Walk directory %S failed." path)
         nil)))))
