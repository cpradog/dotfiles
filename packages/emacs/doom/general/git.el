;;; general/git.el -*- lexical-binding: t; -*-


(after! blamer
  (setq blamer-idle-time 0.1
        blamer-min-offset 70
        blamer-view 'overlay
        blamer-author-formatter " ✎ %s "
        blamer-datetime-formatter "[%s]"
        blamer-commit-formatter "● %s")

  (custom-set-faces '(blamer-face
                        ((t (:foreground "#A6Accd"
                                                  :background nil
                                                  :height 100
                                                  :italic t)))))

  (global-blamer-mode 1))

(provide 'general/git)
;;; git.el ends here
