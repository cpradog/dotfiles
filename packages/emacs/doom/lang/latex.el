;;; lang/latex.el -*- lexical-binding: t; -*-

(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'tex-mode)
              (setq my-flycheck-local-cache '((next-checkers . (tex-chktex)))))))

(provide 'lang/latex)
;;; lang/latex.el ends here
