;;; lang/ledger.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; enable ledger-mode for .journal and hledger files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . ledger-mode))
(add-to-list 'auto-mode-alist '("\\.hledger\\'" . ledger-mode))
(add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode))

;; active journal file
(setq ledger-jfile (expand-file-name "~/.local/share/hledger/current.journal")
      ledger-accounts-file (expand-file-name "~/.local/share/hledger/accounts.ledger"))

;; hledger support
(setq ledger-report-auto-width nil
      ledger-report-use-native-highlighting nil
      ledger-reports '(("balance sheet" "%(binary) -f %(ledger-file) bs")
                       ("income statement" "%(binary) -f %(ledger-file) is")
                       ("balalance" "%(binary) -f %(ledger-file) bal -t --no-elide")
                       ("account" "%(binary) -f %(ledger-file) areg %(account)")))

(map! :map doom-leader-open-map
      :desc "Open current ledger journal"
      "l" #'ledger/open-current-journal
      :desc "Open ledger accounts"
      "L" #'ledger/open-accounts)

(defun ledger/open-current-journal ()
  "Open current ledger journal"
  (interactive)
  (find-file ledger-jfile))

(defun ledger/open-accounts ()
  "Open ledger accounts registry"
  (interactive)
  (find-file ledger-accounts-file))

(use-package! flycheck-hledger
  :after (flycheck ledger-mode)
  :demand t
  :custom ((flycheck-hledger-strict t)
           (flycheck-hledger-checks '("ordereddates"
                                      ;; "payees"
                                      "uniqueleafnames"))))

(provide 'lang/ledger)
;;; ledger.el ends here
