(use-package winum
  :init
  (setq winum-auto-setup-mode-line nil)
  :config
  (general-define-key :prefix my-prefix
		      "1" #'winum-select-window-1
		      "2" #'winum-select-window-2
		      "3" #'winum-select-window-3
		      "4" #'winum-select-window-4
		      "5" #'winum-select-window-5
		      "6" #'winum-select-window-6
		      "7" #'winum-select-window-7
		      "8" #'winum-select-window-8
		      "9" #'winum-select-window-9
		      "m" #'winum-select-window-1
		      "," #'winum-select-window-2
		      "." #'winum-select-window-3
		      "n" #'winum-select-window-4
		      "e" #'winum-select-window-5
		      "i" #'winum-select-window-6
		      "l" #'winum-select-window-7
		      "u" #'winum-select-window-8
		      "y" #'winum-select-window-9)
  (winum-mode))
