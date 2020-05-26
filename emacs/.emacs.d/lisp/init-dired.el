(use-package dired
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches "-hal")
  (dired-dwim-target t))


(use-package dired-x)


(use-package image-dired
  :custom
  (image-dired-thumb-size 500))


(use-package dired-async
  :after dired
  :hook (dired-mode . dired-async-mode))


(use-package browse-url
  :custom
  (browse-url-handlers '(("\\`file:" . browse-url-default-browser))))


(provide 'init-dired)
