;;; general/intl.el -*- lexical-binding: t; -*-

(define-prefix-command 'intl-mode-map)
(global-set-key (kbd "C-'") 'intl-mode-map)
(define-key intl-mode-map (kbd "a") (lambda() (interactive) (insert "á")))
(define-key intl-mode-map (kbd "A") (lambda() (interactive) (insert "Á")))
(define-key intl-mode-map (kbd "e") (lambda() (interactive) (insert "é")))
(define-key intl-mode-map (kbd "E") (lambda() (interactive) (insert "É")))
(define-key intl-mode-map (kbd "i") (lambda() (interactive) (insert "í")))
(define-key intl-mode-map (kbd "I") (lambda() (interactive) (insert "Í")))
(define-key intl-mode-map (kbd "o") (lambda() (interactive) (insert "ó")))
(define-key intl-mode-map (kbd "O") (lambda() (interactive) (insert "Ó")))
(define-key intl-mode-map (kbd "u") (lambda() (interactive) (insert "ú")))
(define-key intl-mode-map (kbd "U") (lambda() (interactive) (insert "Ú")))
(define-key intl-mode-map (kbd "n") (lambda() (interactive) (insert "ñ")))
(define-key intl-mode-map (kbd "N") (lambda() (interactive) (insert "Ñ")))

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq ispell-program-name                (executable-find "hunspell")
      ispell-dictionary                  "es_ES,en_GB,en_US"
      ispell-personal-dictionary         "~/.local/share/dictionary/personal"
      langtool-bin                       "/usr/bin/languagetool"
      langtool-mother-tongue             "es"
      langtool-autoshow-idle-delay       0
      langtool-autoshow-message-function 'langtool-autoshow-detail-popup)

(after! ispell
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic (symbol-value 'ispell-dictionary)))

(provide 'general/intl)
;;; intl.el ends here
