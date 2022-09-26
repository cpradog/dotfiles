;;; lang/elisp.el -*- lexical-binding: t; -*-

(after! highlight-defined
  (add-hook 'emacs-lisp-mode-hook #'highlight-defined-mode))

(defcustom flycheck-elisp-noflycheck-marker ";; no-flycheck"
  "Flycheck line regions marked with this marker string are ignored."
  :type 'string
  :group 'flycheck)

(defun flycheck-elisp-noflycheck (err)
  "Ignore flycheck if line of ERR ends with `flycheck-elisp-noflycheck-marker'."
  (let ((line (or (flycheck-error-end-line err)
                  (flycheck-error-line err))))
    (save-excursion
      (goto-char (point-min))
      (forward-line line)
      (end-of-line)
      (looking-back flycheck-elisp-noflycheck-marker
                    (max (- (point) (length flycheck-elisp-noflycheck-marker))
                         (point-min))))))

(defun elisp-noflycheck-hook ()
  "Add the ;;;###no-flycheck thing to elisp."
  (require 'flycheck)
  (add-hook 'flycheck-process-error-functions #'flycheck-elisp-noflycheck nil t))

(add-hook 'emacs-lisp-mode-hook #'elisp-noflycheck-hook)


(provide 'lang/elisp)
;;; elisp.el ends here
