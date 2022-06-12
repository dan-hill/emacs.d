(require 'package)

(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)


;;-------------------------------------------------------------------------------
;; Registers

(set-register ?z '(file . "~/.emacs.d/init.el"))
(set-register ?x '(file . "~/org/core.org"))


;;-------------------------------------------------------------------------------
;; Theme Configuration

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme `cyberpunk-2019 t)


;;-------------------------------------------------------------------------------
;; Font Configuration
;; Font: https://github.com/source-foundry/Hack
;; https://gist.github.com/dan-hill/0762d21d0ac891ab501ae401376a3e7c
;; Dynamically changes font to a larger size for higher dpi monitors.

(defun set-dynamic-frame-face (frame)
  (interactive)
  (if window-system
      (progn
        (if (> (window-width) 2000)
            (set-frame-parameter frame 'font "Hack 12")
         (set-frame-parameter frame 'font "Hack 11")))))

(set-dynamic-frame-face nil)

(push 'set-dynamic-frame-face after-make-frame-functions)


;;-------------------------------------------------------------------------------
;; Startup Configuration

(setq initial-buffer-choice "~/org/core.org")


;;-------------------------------------------------------------------------------
;; use-package
;; https://github.com/jwiegley/use-package
;; Allows tidy package configuration.

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))


;;-------------------------------------------------------------------------------
;; Diminish
;; https://github.com/emacsmirror/diminish
;; Implements hiding or abbreviation of the mode line displays
;; (lighters) of minor-modes.

(use-package diminish
  :ensure t)


;;-------------------------------------------------------------------------------
;; Helm
;; https://github.com/emacs-helm/helm
;; Adds incremental auto-completion.
(use-package helm
  :ensure t
  :bind (
    ("M-x"     . helm-M-x)
    ("C-x C-f" . helm-find-files)
  :map helm-map
    ("C-j" . helm-next-line)
    ("C-k" . helm-previous-line)))


;;-------------------------------------------------------------------------------
;; org-bullets
;; https://github.com/sabof/org-bullets
;; use UTF-8 characters for org-mode bullets.

(use-package org-bullets
  :ensure t
  :commands
    (org-bullets-mode)
  :init
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;;-------------------------------------------------------------------------------
;; git-auto-commit-mode
;; https://github.com/ryuslash/git-auto-commit-mode
;; Commit and push automatically after save. 
(use-package git-auto-commit-mode
  :ensure t)


;;-------------------------------------------------------------------------------
;; find-lisp
;; Used to rescursivly add all org files in a directory to agenda.
;; This method is simple but slow.
(load-library "find-lisp")


;;-------------------------------------------------------------------------------
;; org-mode
;; https://orgmode.org/
;; Adds org-mode
(use-package org
  :ensure t
  :mode
    ("\\.org\\'" . org-mode)
  :bind
    ("C-c l" . org-store-link)
    ("C-c a" . org-agenda)
    ("C-c c" . org-capture-at-point))
  :config
    (progn
      (setq org-directory "~/org")
      (setq org-default-notes-file (concat org-directory "/capture.org"))
      (setq org-agenda-files (find-lisp-find-files "~/org" "\.org$"))
      (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
      (setq org-log-done t)
      (setq org-startup-indented t)
      (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "CANCELED(c)" "DONE(d)")
	  (sequence "NEED(n)" "SOURCING(s)" "ORDERED(o)" "|" "HAVE(h)" )
	  (sequence "ACTIVE(a)" "ONHOLD(h)" "|" "CANCELED(c)" "DONE(d)")))
      (setq org-todo-keyword-faces
        '(("TODO"     . (:foreground "cyan"    :weight bold))
	  ("WAITING"  . (:foreground "yellow"  :weight bold))
	  ("CANCELED" . (:foreground "red"     :weight bold))
	  ("DONE"     . (:foreground "green"   :weight bold))
	  ("NEED"     . (:foreground "cyan"    :weight bold))
	  ("SOURCING" . (:foreground "yellow"  :weight bold))
	  ("ORDERED"  . (:foreground "yellow"  :weight bold))
	  ("HAVE"     . (:foreground "green"   :weight bold))
	  ("ACTIVE"   . (:foreground "cyan"    :weight bold))
	  ("ONHOLD"   . (:foreground "yellow"  :weight bold)))))


;;-------------------------------------------------------------------------------
;; ox-hugo
;; https://ox-hugo.scripter.co/
;; Exports org files to hugo

(use-package ox-hugo
  :ensure t
  :after ox)


;;-------------------------------------------------------------------------------
;; org-edna
;; https://www.nongnu.org/org-edna-el/
;; Provides advanced todo dependancies.
(use-package org-edna
  :ensure t)
(org-edna-load)


;;-------------------------------------------------------------------------------
;; yasnippet
;; https://github.com/joaotavora/yasnippet
;; Template system.
(use-package yasnippet
  :ensure t)
(yas-global-mode)

;;-------------------------------------------------------------------------------
;; git-modes
;; https://github.com/magit/git-modes/
;; Major mode for editing .gitignore files.

(use-package git-modes
  :ensure t)
