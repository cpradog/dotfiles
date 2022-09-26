(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((lsp-enabled-clients deno-ls json-ls)
     (eval setq lsp-clients-deno-import-map
           (expand-file-name "import-map.json"
                             (locate-dominating-file default-directory "import-map.json"))
           lsp-clients-deno-server
           (expand-file-name "build/bin/deno"
                             (locate-dominating-file default-directory ".git")))
     (eval setq lsp-clients-deno-import-map
           (concat
            (locate-dominating-file default-directory "import-map.json")
            "import-map.json")
           lsp-clients-deno-server
           (concat
            (locate-dominating-file default-directory ".git")
            "build/bin/deno"))
     (eval setq lsp-clients-deno-import-map
           (locate-dominating-file default-directory "import-map.json"))
     (lsp-clients-deno-server . "./build/deno")
     (lsp-enabled-clients deno-ls)
     (lsp-clients-deno-server concat
                              (pwd)
                              "/build/deno")
     (lsp-enabled-clients quote
                          (deno-ls))
     (lsp-clients-deno-server concat
                              (pwd)
                              "build/deno")
     (lsp-enabled-clients quote deno)))
 '(warning-suppress-log-types '(doom-first-buffer-hook))
 '(warning-suppress-types '(doom-first-buffer-hook)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "#A6Accd"))))
 '(hl-line ((t (:background "#32374c")))))
