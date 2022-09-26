;;; lang/sh.el -*- lexical-binding: t; -*-

(set-formatter! 'altshfmt
  '("altshfmt" "-ci"
    ("-i" "%d" (unless indent-tabs-mode tab-width))
    ("-ln" "%s" (pcase sh-shell (`bash "bash") (`mksh "mksh") (_ "posix"))))
  :modes '(sh-mode))

(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'sh-mode)
              (setq my-flycheck-local-cache '((next-checkers . (sh-shellcheck)))))))

(provide 'lang/sh)
;;; sh.el ends here
