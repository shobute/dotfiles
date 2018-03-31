(use-package exwm
  :init
  (menu-bar-mode -1)
  
  (setq mouse-autoselect-window t)
  (setq focus-follows-mouse t)
  
  (setq display-time-default-load-average nil)
  (setq display-time-day-and-date t)
  (setq display-time-24hr-format t)
  (display-time-mode t)  
  
  :config
  (setq exwm-workspace-show-all-buffers t)
  (setq exwm-layout-show-all-buffers t)
  
  (exwm-input-set-key (kbd "<f5> R") #'exwm-reset)
  
  (setq exwm-input-simulation-keys
	'(([?\s-c] . [C-c])
	  ([?\s-v] . [C-v])
	  ([?\s-x] . [C-x])
	  ([?\s-z] . [C-z])
	  ([?\C-u] . [prior])
	  ([?\C-d] . [next])))
  
  (require 'exwm-randr)
  (setq exwm-workspace-number 2)
  (setq exwm-randr-workspace-output-plist '(1 "DVI-1"))
  (add-hook 'exwm-randr-screen-change-hook
	    (lambda ()
	      (start-process-shell-command
	       "xrandr" nil "xrandr --output DVI-1 --right-of DVI-0 --auto")))
  (exwm-randr-enable)
  
  (require 'exwm)
  (require 'exwm-config)

  (add-hook 'exwm-update-class-hook  
	    (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  (exwm-config-misc)
  (exwm-enable))