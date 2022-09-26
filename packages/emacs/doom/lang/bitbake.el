;;; lang/bitbake.el -*- lexical-binding: t; -*-

(use-package! bitbake
  :mode (("\\.bb.*\\'" . bitbake-mode)
         ("meta-.*\\.inc\\'" . bitbake-mode)))

(provide 'lang/bitbake)
;; lang/bitbake.el ends here
