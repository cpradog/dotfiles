;;; general/windows.el -*- lexical-binding: t; -*-

(map!
 ;; Window Movements
 "C-h"    #'evil-window-left
 "C-j"    #'evil-window-down
 "C-k"    #'evil-window-up
 "C-l"    #'evil-window-right)

(provide 'general/windows)
;;; windows.el ends here
