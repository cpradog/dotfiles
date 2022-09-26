;;; general/email.el -*- lexical-binding: t; -*-

(setq +mu4e-backend nil)
(after! mu4e
  (setq mu4e-get-mail-command "~/.local/bin/mail-sync"
        sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail
        mu4e-change-filenames-when-moving t)

  (set-email-account! "cpradog.com"
    '((mu4e-sent-folder       . "/cpradog/Sent")
      (mu4e-drafts-folder     . "/cpradog/Drafts")
      (mu4e-trash-folder      . "/cpradog/Trash")
      (mu4e-refile-folder     . "/cpradog/Archive")
      (smtpmail-smtp-user     . "carlos.prado@cpradog.com")
      (mu4e-compose-signature . "---\n Carlos Prado García"))
    t))

(provide 'general/email)
;;; email.el ends here
