(load "server")
(unless (server-running-p) (server-start))

(setq custom-file (make-temp-file "emacs-custom")
      create-lockfiles nil
      make-backup-files nil)
(setq browse-url-generic-program "firefox")
(setq-default tab-width 4
              indent-tabs-mode nil)

(load "~/.emacs.d/funcs.el")

(package-initialize)
(my-use-package-initialize)

(general-create-definer my-leader-def
  :states 'normal
  :keymaps 'override
  :prefix "SPC"
  :non-normal-prefix "C-SPC")

(define-key key-translation-map (kbd "SPC c") (kbd "C-c"))
(my-leader-def
  "f" '(:ignore t :which-key "File")
  "f d" #'dired-jump
  "f s" #'save-buffer
  "f y" #'my-show-buffer-file-name

  "<tab>" #'my-alternate-buffer
  "<return>" #'eshell
  "!" #'shell-command)

(general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil)

(mapc 'load (file-expand-wildcards "~/.emacs.d/packages/*.el"))

(let ((ws-config (concat
                  "~/.emacs.d/window-system/"
                  (symbol-name window-system)
                  ".el")))
  (when (file-readable-p ws-config)
    (load ws-config)))


(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq recentf-max-saved-items 999)
(recentf-mode 1)

(show-paren-mode 1)
(flyspell-mode)
