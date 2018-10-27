;;; init-packages.el --- Packages manager configuration

;;; Commentary:
;;
;; Packages manager configuration
;;

;;; Code:

(require 'package)

(defvar require-package-list '())

(defun require-packages (package-list)
  "Fetch the list of packages available, PACKAGE-LIST is the list you want to install."
  (unless package-archive-contents
    (package-refresh-contents))

  (setq require-package-list
        (append require-package-list
                package-list))
  
  ;; install the missing packages
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

(require-packages '(use-package))

(provide 'init-packages)

;;; init-packages.el ends here
