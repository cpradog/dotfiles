;;; plantuml.el -*- lexical-binding: t; -*-

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(setq plantuml-exec-mode 'jar
      plantuml-jar-path "/usr/share/plantuml/lib/plantuml.jar")

(when (eq system-type 'darwin)
      (setq plantuml-exec-mode 'jar
            plantuml-jar-path "/opt/local/share/java/plantuml.jar"))

(provide 'lang/plantuml)
;;; plantuml.el ends here
