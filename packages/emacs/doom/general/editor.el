;;; general/editor.el -*- lexical-binding: t; -*-

;; add single space after sentence
(setq sentence-end-double-space nil)

;; delete selected text on type
(delete-selection-mode 1)

;; default indentation and line manipulation
(setq tab-width                             2
      standard-indent                       2
      c-basic-offset                        2
      indent-tabs-mode                      nil
      tab-always-indent                     'complete
      tab-first-completion                  'word-or-paren-or-punct
      c-tab-always-indent                   nil
      indent-line-function                  'insert-tab
      backward-delete-char-untabify-method  nil
      kill-whole-line                       t)

;; disable autosave files
(setq auto-save-default nil)

;; reload file changed externaly
(global-auto-revert-mode t)

;; disable text zoom
(global-set-key (kbd "<C-wheel-down>") nil)
(global-set-key (kbd "<C-wheel-up>") nil)

(provide 'general/editor)
;;; editor.el ends here
