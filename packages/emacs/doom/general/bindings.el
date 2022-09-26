;;; ../../.dotfiles/doom/config/general/bindings.el -*- lexical-binding: t; -*-

;; restore inserting special characters with alt+number in mac
(map! :i "M-1" (lambda() (interactive) (insert "¡")))
(map! :i "M-2" (lambda() (interactive) (insert "€")))
(map! :i "M-3" (lambda() (interactive) (insert "#")))
(map! :i "M-4" (lambda() (interactive) (insert "¢")))
(map! :i "M-5" (lambda() (interactive) (insert "∞")))
(map! :i "M-6" (lambda() (interactive) (insert "§")))
(map! :i "M-7" (lambda() (interactive) (insert "¶")))
(map! :i "M-8" (lambda() (interactive) (insert "•")))
(map! :i "M-9" (lambda() (interactive) (insert "ª")))
(map! :i "M-0" (lambda() (interactive) (insert "º")))

;; disable macro recording
(map! :n "q" nil)
(map! :n "Q" nil)

;; common mistakes
(evil-ex-define-cmd "W[rite]" 'evil-write)
(evil-ex-define-cmd "Wa[ll]" 'evil-write-all)
(evil-ex-define-cmd "WA[ll]" 'evil-write-all)
(evil-ex-define-cmd "Wq" 'evil-save-and-close)
(evil-ex-define-cmd "WQ" 'evil-save-and-close)
(evil-ex-define-cmd "Q[uit]" 'evil-quit)
(evil-ex-define-cmd "Qa[ll]" 'evil-quit-all)
(evil-ex-define-cmd "QA[ll]" 'evil-quit-all)

(provide 'general/bindings)
;;; bindings.el ends here
