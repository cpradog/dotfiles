;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Carlos Prado"
      user-mail-address "carlos.prado@cpradog.com")

;; load all configuration sections
(add-to-list 'load-path doom-private-dir t)
(mapc (lambda (section)
        (mapc (lambda (file)
                (require (intern (concat section "/" (file-name-base file)))))
              (file-expand-wildcards (expand-file-name "*.el"
                                                       (expand-file-name section doom-private-dir)))))
      '("general"
        "lang"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! meson-mode
  (add-hook! meson-mode-hook 'company))

(setq emojify-download-emojis-p t)
