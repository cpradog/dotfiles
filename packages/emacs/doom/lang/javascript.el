;;; javascript.el -*- lexical-binding: t; -*-

(setq js-indent-level                                                                     2
      typescript-indent-level                                                             2
      jest-executable                                                                     "./node_modules/.bin/jest"
      lsp-javascript-format-enable                                                        nil
      lsp-typescript-format-enable                                                        nil
      lsp-javascript-format-insert-space-after-opening-and-before-closing-nonempty-braces nil
      lsp-typescript-format-insert-space-after-opening-and-before-closing-nonempty-braces nil)

(use-package! jest
  :after (js2-mode)
  :hook (js2-mode . jest-minor-mode))

(provide 'lang/javascript)
;;; javascript.el ends here
