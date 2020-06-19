(use-package evil
  :demand
  :straight t
  :bind (:map evil-window-map
         ("C-f" . other-frame)
         :map evil-motion-state-map
         ("<up>") ("<down>") ("RET")
         :map evil-visual-state-map
         ("v" . evil-visual-line))

  :custom
  (evil-disable-insert-state-bindings t)
  (evil-default-state 'insert)
  (evil-emacs-state-modes nil)
  (evil-motion-state-modes nil)
  (evil-normal-state-modes '(prog-mode text-mode fundamental-mode))

  (evil-lookup-func (lambda () (call-interactively #'man))) ; Woman doesn't work on OpenBSD
  (evil-mode-line-format 'after)
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-keybinding nil)
  (evil-want-minibuffer t)

  :config
  (evil-mode 1)

  ;; This is needed because we disable evil insert state bindings, but still want C-w.
  (evil-global-set-key 'insert (kbd "C-w") 'evil-window-map)

  ;; Get rid of undo-tree.
  (with-eval-after-load 'undo-tree
    (global-set-key [remap undo-tree-undo] #'undo-only)
    (global-set-key [remap undo-tree-redo] #'undo-redo) ; Emacs 28
    (global-undo-tree-mode -1))
  (evil-define-key '(normal visual) global-map
    "U"    #'undo
    "u"    #'undo-only
    "\C-r" #'undo-redo))           ; Emacs 28


(use-package evil-surround
  :after evil
  :straight t

  :config
  (evil-define-key '(normal operator) global-map "s" 'evil-surround-edit)
  (evil-define-key 'visual global-map "s" 'evil-surround-region))


;; Great for Python
(use-package evil-indent-plus
  :after evil
  :straight t
  :bind (:map evil-inner-text-objects-map
              ("i" . evil-indent-plus-i-indent)
         :map evil-outer-text-objects-map
              ("i" . evil-indent-plus-a-indent)))


;; Great for HTML
(use-package evil-matchit
  :straight t

  :config
  (global-evil-matchit-mode 1))


(use-package winner
  :after evil
  :demand
  :bind (:map evil-window-map
    ("u"   . winner-undo)
    ("C-u" . winner-undo)
    ("C-r" . winner-redo))

  :config
  (winner-mode 1))


(use-package dumb-jump
  :after evil
  :straight t

  :init
  (defun my/evil-goto-definition-dumb-jump (_string _position)
    "Jump to definition with dumb-jump. Error if no jump candidate found."
    (unless (dumb-jump-go)
      (user-error nil)))

  :custom
  (evil-goto-definition-functions
   '(evil-goto-definition-xref
     evil-goto-definition-semantic
     my/evil-goto-definition-dumb-jump
     evil-goto-definition-imenu
     evil-goto-definition-search)))


(provide 'init-evil)
