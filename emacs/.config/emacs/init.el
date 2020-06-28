(customize-set-variable 'network-security-level 'paranoid)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


(defmacro my/format-sexp (sexp &rest objects)
  "Format an expression as if it were a string.

See `format' for replacement syntax."
  `(eval (read (format ,(format "%S" sexp) ,@objects))))


(require 'init-core)
(require 'init-theme)
(require 'init-minibuffer)
(require 'init-password-gen)

;; Minor modes
(require 'init-evil)
(require 'init-yasnippet)
(require 'init-grep)

;; Major modes
(require 'init-shell)
(require 'init-vc)
(require 'init-dired)
(require 'init-operating-system)
(require 'init-restclient)
(require 'init-large-files)
(require 'init-prog-modes)
(require 'init-text-modes)
