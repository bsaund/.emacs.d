;; WARNING: THIS FILE IS NOT LOADED ON STARTUP.
;; LOOK AT init.el INSTEAD


(add-to-list 'load-path "~/.emacs.d/")

(load "arduino-mode.el")
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(add-hook 'text-mode-hook' visual-line-mode)


;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(inhibit-startup-screen t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )


;; setup custom for latex
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-PDF-mode t)


; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.sdf$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.world$" . xml-mode))
