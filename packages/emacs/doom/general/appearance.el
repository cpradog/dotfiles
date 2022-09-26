;;; general/appearance.el -*- lexical-binding: t; -*-

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-font  "Iosevka Mono-12"
      doom-theme 'doom-palenight)

(when (eq system-type 'darwin)
  (setq doom-font  "Iosevka Code-12"))

;; quit without asking
(setq confirm-kill-emacs nil)

(custom-set-faces '(font-lock-comment-face
                    ((t (:foreground "#A6Accd"))))
                  '(hl-line
                    ((t (:background "#32374c")))))

;; ensure starts maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; highlight tabs (characters)
(setq whitespace-style          '(face trailing tabs)
      show-trailing-whitespace  t)
(add-hook! (prog-mode text-mode) #'whitespace-mode)
(add-hook! (prog-mode text-mode) #'rainbow-mode)

(after! centaur-tabs
  (setq centaur-tabs-style                  "slant"
        centaur-tabs-set-icons              t
        centaur-tabs-set-bar                'left
        centaur-tabs-cycle-scope            'tabs
        centaur-tabs-enable-key-bindings    t)

  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project))

(setq highlight-indent-guides-method      'bitmap
      highlight-indent-guides-responsive  'top
      highlight-indent-guides-delay       0)

(setq scroll-step                     1
      scroll-conservatively           10000
      scroll-preserve-screen-position t
      scroll-margin                   5
      mouse-wheel-progressive-speed   nil)

(provide 'general/appearance)
;;; appearance.el ends here
