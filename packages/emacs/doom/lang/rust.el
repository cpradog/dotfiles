;;; lang/rust.el -*- lexical-binding: t; -*-

(after! dap-mode
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  ;; installs .extension/vscode
  (dap-gdb-lldb-setup)
  (dap-register-debug-template "Rust::LLDB Run Configuration"
                               (list :type "lldb"
                                     :request "launch"
                                     :name "LLDB::Run"
                                     :gdbpath "rust-lldb"
                                     :target nil
                                     :cwd nil))

  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
                                     :gdbpath "rust-gdb"
                                     :target nil
                                     :cwd nil)))

(use-package! pest-mode
  :mode "\\.pest\\'"
  :hook (pest-mode . flymake-mode))

(provide 'lang/rust)
;; rust.el ends here
