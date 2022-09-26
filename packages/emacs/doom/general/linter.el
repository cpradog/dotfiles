;;; general/linter.el -*- lexical-binding: t; -*-

(setq flycheck-emacs-lisp-load-path                     'inherit
      flycheck-check-syntax-automatically               '(save mode-enabled new-line idle-change idle-buffer-switch)
      flycheck-buffer-switch-check-inmediate-buffers    t
      flycheck-display-errors-delay                     0.25)

(defadvice flycheck-error-list-refresh (around shrink-error-list activate)
        ad-do-it
        (-when-let (window (flycheck-get-error-list-window t))
                (with-selected-window window)
                (fit-window-to-buffer window 30)))

;; Add buffer local Flycheck checkers after LSP for different major modes.
(defvar-local my-flycheck-local-cache nil)
(defun my-flycheck-local-checker-get (fn checker property)
  ;; Only check the buffer local cache for the LSP checker, otherwise we get
  ;; infinite loops.
  (if (eq checker 'lsp)
      (or (alist-get property my-flycheck-local-cache)
          (funcall fn checker property))
      (funcall fn checker property)))

(advice-add 'flycheck-checker-get
        :around 'my-flycheck-local-checker-get)

(provide 'general/linter)
;;; linter.el ends here
