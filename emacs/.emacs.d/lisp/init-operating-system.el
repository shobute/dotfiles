;; Things a text editor has no buisness doing. ;-)

(use-package exwm
  ;; TODO: Automaticlaly bind any unmapped `s-?` keys to `C-c ?` if it exists, else `C-x ?`.
  :if (eq window-system 'x)
  :straight t

  :init
  (defun my/exwm-set-buffer-name ()
    "Add the application's class name to the buffer name."
    (exwm-workspace-rename-buffer (concat "*EXWM*<" exwm-class-name ">")))

  (defun my/gtk-launch ()
    "Launch an X application via `gtk-launch'."
    (interactive)

    (let* ((extention "\\.desktop$")
           (dirs (mapcar (lambda (dir) (expand-file-name "applications" dir))
                         (cons (xdg-data-home) (xdg-data-dirs))))
           (apps (cl-loop for dir in dirs
                          if (file-exists-p dir)
                          append (cl-loop for file in (directory-files dir nil extention)
                                          collect (replace-regexp-in-string extention "" file)))))

      (call-process "gtk-launch" nil 0 nil (completing-read "Launch: " apps))))

  :hook (exwm-update-class . my/exwm-set-buffer-name)

  :init
  (setq focus-follows-mouse t)

  :custom
  (exwm-randr-workspace-monitor-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-simulation-keys
   '(([?\s-x] .  [?\C-x])
     ([?\s-c] .  [?\C-c])
     ([?\s-w] .  [?\C-w])
     ([?\s-a] .  [?\C-a])
     ([?\s-v] .  [?\C-v])))
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([?\s-o] . exwm-workspace-swap)
     ([?\s-b] . switch-to-buffer)
     ([?\s-p] . my/gtk-launch)
     ([?\s-g] . (lambda () (interactive) (shell-command "xrandr --output HDMI-2 --auto")))))

  :config
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
   'exwm-randr-screen-change-hook
   (lambda ()
     (start-process-shell-command
      "xrandr" nil "xrandr --output HDMI-2 --auto --output DP-1 --auto --right-of HDMI-2")))
  (exwm-randr-enable))


(use-package time
  :after exwm

  :custom
  (display-time-format "%F %R\t")
  (display-time-default-load-average nil)

  :config
  (display-time-mode t))


(use-package emms
  :straight t

  :bind (("s-," . emms-previous)
         ("s-." . emms-next)
         ("s-m" . emms-pause))

  :custom
  (emms-source-file-default-directory "/mnt/sandisk/music")

  :config
  ;; (setq emms-volume-mixerctl-change nil) ;; TODO: What should this be? Why is it void?
  (require 'emms-setup)
  (require 'emms-mode-line)
  (require 'emms-volume-mixerctl)
  (emms-all)
  (emms-default-players)
  (emms-mode-line 1))


(use-package calc
  :defer t

  :config
  ;; Get latest exchange rates
  (with-current-buffer (url-retrieve-synchronously "https://api.openrates.io/latest")
    (let* ((exch (json-read))
           (base (intern (cdr (assq 'base exch)))))
      (setq math-additional-units
            (cons
             (list base nil "Base currency")
             (cl-loop for (curr . rate) in (cdr (assq 'rates exch))
                      collect (list curr (format "%f %s" (/ rate) base)
                                    (format "Currency %s in terms of %s" curr base))))
            math-units-table nil))))


(use-package erc
  :config
  (setq erc-lurker-hide-list '("JOIN" "PART" "QUIT")
        erc-lurker-threshold-time 3600)
  (setq erc-join-buffer 'bury)
  (setq erc-nick "Ben`")
  (setq erc-format-query-as-channel-p t
        erc-track-priority-faces-only 'all
        erc-track-faces-priority-list '(erc-error-face
                                        erc-current-nick-face
                                        erc-keyword-face
                                        erc-nick-msg-face
                                        erc-direct-msg-face
                                        erc-dangerous-host-face
                                        erc-notice-face
                                        erc-prompt-face)))


(provide 'init-operating-system)
