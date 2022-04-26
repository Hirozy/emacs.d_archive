;;; init-minibuffer.el --- minibuffer configuration -*- lexical-binding: t -*-

;;; Commentary:
;;
;; minibuffer configuration
;;

;;; Code:

(defun defined/use-orderless-in-minibuffer ()
  "Use `orderless' in minibuffer."
  (setq-local completion-styles '(orderless)))

(use-package vertico
  :hook ((after-init . vertico-mode)
         (minibuffer-setup . defined/use-orderless-in-minibuffer))
  :bind (:map vertico-map
              ("?" . minibuffer-completion-help)
              ("C-v" . vertico-scroll-up)
              ("M-v" . vertico-scroll-down)
              ("<tab>" . vertico-insert)
              ("M-RET" . vertico-exit-input))
  :config
  (vertico-indexed-mode))

(use-package vertico-directory
  :after vertico
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package consult
  :defines (consult-project-root-function)
  :bind (;; remap projectile
         ([remap projectile-ripgrep] . consult-ripgrep)
         ([remap projectile-grep] . consult-grep)
         ([remap projectile-recentf] . consult-projectile-recentf)
         ([remap projectile-switch-to-buffer] . consult-projectile-switch-to-buffer)
         ([remap projectile-find-file] . consult-projectile-find-file)
         ([remap projectile-find-dir] . consult-projectile-find-dir)
         ([remap projectile-switch-project] . consult-projectile-switch-project)
         ;; remap yasnippet
         ([remap yas-insert-snippet] . consult-yasnippet)
         ([remap yas-visit-snippet-file] . consult-yasnippet-visit-snippet-file)
         ;; consult keymap
         ("C-c l" . consult-flycheck))

  :config
  (setq consult-project-root-function 'projectile-project-root
        consult-async-refresh-delay 0
        consult-async-input-throttle 0
        consult-async-input-debounce 0
        ;; disable all preview
        consult-preview-key (kbd "M-.")))

(use-package consult-dir
  :commands consult-dir
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package orderless
  :custom
  (completion-styles '(flex))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package embark
  :after vertico
  :bind (:map vertico-map
              ("C-c C-o" . embark-export)
              ("C-c C-c" . embark-act)))

(provide 'init-minibuffer)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; init-minibuffer.el ends here
