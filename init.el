;; (add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/lisp")
;; (add-to-list 'load-path "~/.emacs.d/lisp/ein")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-hook 'text-mode-hook' visual-line-mode)

(package-initialize)

(require 'cl)
(require 'cl-lib)
(require 'validate)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (cmake-mode yasnippet websocket validate use-package json-mode flycheck-ycmd el-get company-ycmd))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; setup custom for latex
(add-hook 'latex-mode-hook 'flyspell-mode)
;; (add-hook 'latex-mode-hook 'LaTeX-math-mode)
;; (add-hook 'latex-mode-hook 'TeX-source-correlate-mode)
;; (setq TeX-PDF-mode t)


;  xml syntax
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.sdf$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.world$" . xml-mode))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

; yaml syntax
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

; json syntax
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;  arduino
(load "arduino-mode.el")

;  Matlab
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")

;; Python

(add-hook 'python-mode-hook
          (lambda ()
            (setq python-indent 4)
            (setq tab-width 4)))

;; ; ein
;; (require 'ein)


; Save backups in a separate directory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups



;incrementing numbers
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)

(setq-default c-default-style "linux"
              c-basic-offset 4)

(setq-default indent-tabs-mode nil)


;load org mode
(add-to-list `load-path "~/.emacs.d/org_mode/org-9.0.9/lisp")









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;YCMD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Snippets
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode t))

;; Autocomplete
(use-package company
  :defer 10
  :diminish company-mode
  :bind (:map company-active-map
              ("M-j" . company-select-next)
              ("M-k" . company-select-previous))
  :preface
  ;; enable yasnippet everywhere
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or 
         (not company-mode/enable-yas) 
         (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  :init (global-company-mode t)
  :config
  ;; no delay no autocomplete
  (validate-setq
   company-idle-delay 0
   company-minimum-prefix-length 2
   company-tooltip-limit 20)

  (validate-setq company-backends 
                 (mapcar #'company-mode/backend-with-yas company-backends)))



;; Code-comprehension server
(use-package ycmd
  :ensure t
  :init (add-hook 'c++-mode-hook #'ycmd-mode)
  :config
  (set-variable 'ycmd-server-command '("python2" "/home/bradsaund/programs/ycmd/ycmd"))
  (set-variable 'ycmd-global-config (expand-file-name "/home/bradsaund/programs/ycmd/cpp/ycm/.ycm_extra_conf.py"))

  (set-variable 'ycmd-extra-conf-whitelist '("~/catkin_ws/*"))

  (use-package company-ycmd
    :ensure t
    :init (company-ycmd-setup)
    :config (add-to-list 'company-backends (company-mode/backend-with-yas 'company-ycmd))))


;; On-the-fly syntax checking
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init (global-flycheck-mode t))

(use-package flycheck-ycmd
  :commands (flycheck-ycmd-setup)
  :init (add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup))

;; Show argument list in echo area
(use-package eldoc
  :diminish eldoc-mode
  :init (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

