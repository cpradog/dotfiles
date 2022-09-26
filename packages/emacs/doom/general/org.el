;;; general/org.el -- org-mode configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; code:

(setq org-directory (cond ((eq system-type 'darwin) "~/Documents/org/")
                          (t "~/documents/org/")))

(defvar +org-capture-inbox-file (expand-file-name "inbox.org" org-directory))
(defvar +org-capture-todo-file (expand-file-name "todo.org" org-directory))
(defvar +org-capture-notes-file (expand-file-name "notes.org" org-directory))
(defvar +org-capture-projects-file (expand-file-name "projects.org" org-directory))
(defvar +org-capture-journal-file (expand-file-name "journal.org" org-directory))
(defvar +org-capture-calendar-file (expand-file-name "calendar.org" org-directory))

(setq org-agenda-files (list
                        +org-capture-inbox-file
                        +org-capture-todo-file
                        +org-capture-notes-file
                        +org-capture-projects-file
                        +org-capture-journal-file
                        +org-capture-calendar-file)
      org-default-notes-file +org-capture-inbox-file)

(after! org-fancy-priorities
  (setq org-fancy-priorities-list '((?A "⚡")
                                    (?B "⬆")
                                    (?C "⬇")
                                    (?D "☕"))))

(map! :map doom-leader-open-map
      :desc "Open org inbox"
      "i" #'org/open-inbox)

(map! :map org-mode-map
      "C-'" nil)

(defun org/open-inbox ()
  "Open org inbox"
  (interactive)
  (find-file (expand-file-name +org-capture-inbox-file org-directory)))

;; enable appointment notifications
(org-agenda-to-appt)

(after! org-capture
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file +org-capture-inbox-file)
           "* TODO %?\n/Entered on/ %U")

          ("a" "Appointment" entry
           (file +org-capture-calendar-file)
           "* %^{subject}\n %^T\n %^{description}\n %^g" :time-prompt t :immediate-finish t)

          ("e" "email" entry
           (file +org-capture-inbox-file)
           "* TODO Reply: %a :@computer:@internet:" :immediate-finish t)

          ("c" "org-protocol-capture" entry
           (file +org-capture-inbox-file)
           "* TODO [[%:link][%:description]] :@computer:@internet:\n\n %i" :immediate-finish t)

          ;; ("t" "Personal todo" entry
          ;;  (file+headline +org-capture-todo-file "Inbox")
          ;;  "* [ ] %?\n%i\n%a" :prepend t)

          ;; ("n" "Personal notes" entry
          ;;  (file+headline +org-capture-notes-file "Inbox")
          ;;  "* %u %?\n%i\n%a" :prepend t)

          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a" :prepend t)

          ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; {todo,notes,changelog}.org file is found in a parent directory.
          ;; Uses the basename from `+org-capture-todo-file',
          ;; `+org-capture-changelog-file' and `+org-capture-notes-file'.
          ("p" "Templates for projects")

          ("pt" "Project-local todo" entry  ; {project-root}/todo.org
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)

          ("pn" "Project-local notes" entry  ; {project-root}/notes.org
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a" :prepend t)

          ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)

          ;; Will use {org-directory}/{+org-capture-projects-file} and store
          ;; these under {ProjectName}/{Tasks,Notes,Changelog} headings. They
          ;; support `:parents' to specify what headings to put them under, e.g.
          ;; :parents ("Projects")
          ("o" "Centralized templates for projects")

          ("ot" "Project todo" entry
           (function +org-capture-central-project-todo-file)
           "* TODO %?\n %i\n %a"
           :heading "Tasks"
           :prepend nil)

          ("on" "Project notes" entry
           (function +org-capture-central-project-notes-file)
           "* %U %?\n %i\n %a"
           :heading "Notes"
           :prepend t)

          ("oc" "Project changelog" entry
           (function +org-capture-central-project-changelog-file)
           "* %U %?\n %i\n %a"
           :heading "Changelog"
           :prepend t))))

(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda "" (
                      (org-agenda-skip-scheduled-if-done nil)
                      (org-agenda-time-leading-zero t)
                      (org-agenda-timegrid-use-ampm nil)
                      (org-agenda-skip-timestamp-if-done t)
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-start-day "+0d")
                      (org-agenda-span 7)
                      (org-agenda-overriding-header
                       (propertize  "- Calendar -" 'face
                                    '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))
                      (org-agenda-repeating-timestamp-show-all nil)
                      (org-agenda-prefix-format "   %i %?-2 t%s")
                      (org-agenda-time)
                      (org-agenda-remove-tags nil)
                      (org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ NOW")
                      (org-agenda-scheduled-leaders '("" ""))
                      (org-agenda-deadline-leaders '("Deadline:  " "In %3d d.: " "%2d d. ago: "))
                      (org-agenda-time-grid (quote ((today require-timed remove-match) () "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈")))))

          (todo "NEXT|WAITING"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-overriding-header
                  (propertize  "- Tasks -" 'face
                               '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))))

          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-show-all-dates nil)
                   (org-deadline-warning-days 0)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header
                    (propertize  "- Deadlines - " 'face
                                 '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))))

          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header
                       (propertize  "- Inbox -" 'face
                                    '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))))

          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header
                  (propertize  "- Completed Today -" 'face
                               '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))))

          (todo "TODO" (
                        (org-agenda-overriding-header
                         (propertize  "- All To-Dos -" 'face
                                      '(:foreground "#FFB11B" :height 150 :weight bold :slant italic)))
                        (org-agenda-sorting-strategy '(priority-down))
                        (org-agenda-remove-tags t)
                        (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)
                        (org-agenda-todo-ignore-scheduled 'all)
                        (org-agenda-prefix-format "   %-2i %?b")
                        (org-agenda-todo-keyword-format "")))))


        ("w" "Completed and/or deferred tasks from previous week"
         ((agenda ""
                  ((org-agenda-span 7)
                   (org-agenda-start-day "-7d")
                   (org-agenda-entry-types '(:timestamp))
                   (org-agenda-show-log t)))))))

(provide 'general/org)
;;; org.el ends here
