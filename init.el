;;; custom:coustom
;;;


;;
;; coustom
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (google-c-style google-set-c-style ox-reveal org-re-reveal ggtags yasnippet-snippets yasnippet irony-eldoc flycheck-irony company-irony company-irony-c-headers irony ag counsel-projectile projectile magit flycheck which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Lucida Console" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))


(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package dracula-theme
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'dracula t))

(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d%d")
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("\C-x \C-f" . counsel-find-file)))

(use-package swiper
  :ensure t
  :bind(("\C-s" . swiper)))

;;
;; yasnippet
;;

(use-package yasnippet
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (yas-reload-all))
(use-package yasnippet-snippets
  :ensure t)

(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'emacs-lisp-mode)
		(ggtags-mode 1)))))

(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 3))


;  (setq company-backends
;	'((company-files company-yasnippet company-capf company-keywords)
;	  (company-abbrev company-dabbrev))))

;(add-hook 'emacs-lisp-mode-hook (lambda()
;				  (add-to-list (make-local-variable 'company-backends)
;					       'company-elisp)))


;;
;; change C-n C-p to company selecte in company buffer
;;
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "\C-n") #'company-select-next)
  (define-key company-active-map (kbd "\C-p") #'company-select-previous))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode t))

;;
;; magit
;;
(use-package magit
  :ensure t
  :bind(("\C-x g" . magit-status)))

;;
;; projectile
;;
(use-package projectile
  :ensure t
  :bind-keymap ("\C-c p" . projectile-command-map)
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy)
  (use-package counsel-projectile
    :ensure t))

;;
;;ag
;;
(use-package ag
  :ensure t)

(use-package autoinsert
  :init
  (setq auto-insert-query nil)
  (setq auto-insert-direcotry (locate-user-emacs-file "templates"))
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode 1)
  ;;:config
  ;;(define-auto-insert "\\.h" "htemplate.h")
  ;;(define-auto-insert "\\.hpp" "hpptemplate.hpp")
  ;;(define-auto-insert "\\.cpp" "cpptemplate.cpp")
  )

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (when (boundp 'w32-pipe-read-delay)
    (setq w32-pipe-read-delay 0))
  (when (boundp 'w32-pipe-buffer-size)
    (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
  )

;; (use-package company-irony
;;   :ensure t
;;   :config
;;   (require 'company)
;;   (add-to-list 'company-backends 'company-irony))

(use-package company-irony-c-headers
  :ensure t)

(use-package irony-eldoc
  :ensure t
  :config
  (add-hook 'irony-mode-hook 'irony-eldoc))
;  (use-package company-irony-c-headers
;    :ensure t)
;  (use-package company-irony
;    :ensure t
;    :config
  ;;   (add-to-list (make-local-variable 'company-backends)
  ;; 		 '(company-irony company-irony-c-headers)))
  ;; (use-package flycheck-irony
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))
  ;; (use-package irony-eldoc
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'irony-mode-hook 'irony-eldoc)))

;; (with-eval-after-load 'company
;;   (add-hook 'c++-mode-hook 'company-mode)
;;   (add-hook 'c-mode-hook 'company-mode))

(use-package org-re-reveal
  :ensure t)
(setq org-re-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")


(use-package google-c-style
  :ensure t
  :config
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c++-mode-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  (add-hook 'c++-mode-hook 'google-make-newline-indent))

(provide 'init)

;;; init.el ends here
