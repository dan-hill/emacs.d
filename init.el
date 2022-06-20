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
(require 'package)

(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

;;-------------------------------------------------------------------------------
;; UI Configuration

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq visible-bell t)

(modify-all-frames-parameters
 '((right-divider-width . 0)
   (internal-border-width . 10)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

;;-------------------------------------------------------------------------------
;; Registers

(set-register ?z '(file . "~/.emacs.d/init.el"))
(set-register ?x '(file . "~/org/core.org"))


;;-------------------------------------------------------------------------------
;; Theme Configuration

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme `cyberpunk-2019 t)


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
;; Major mode for editing .git files.

(use-package git-modes
  :ensure t)


;;-------------------------------------------------------------------------------
;; org-modern
;; https://github.com/magit/git-modes/
;; Many org-mode ux tweaks.

 (use-package org-modern
   :ensure t
   :config
   (progn
     (setq org-auto-align-tags nil)
     (setq org-tags-column 0)
     (setq org-catch-invisible-edits 'show-and-error)
     (setq org-special-ctrl-a/e t)
     (setq org-insert-heading-respect-content t)
     (setq org-hide-emphasis-markers t)
     (setq org-pretty-entities t)
     (setq org-ellipsis "…")
     (setq org-agenda-tags-column 0)
     (setq org-agenda-block-separator ?─)
     (setq org-agenda-time-grid
	   '((daily today require-timed)
	     (800 1000 1200 1400 1600 1800 2000)
	     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
     (setq org-agenda-current-time-string
	   "⭠ now ─────────────────────────────────────────────────")))

(global-org-modern-mode)


;;-------------------------------------------------------------------------------
;; Font Configuration
;; Font: https://github.com/be5invis/Iosevka

(with-eval-after-load 'org-faces
(set-face-attribute 'default nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
(set-face-attribute 'org-modern-symbol nil :family "Iosevka"))


;;-------------------------------------------------------------------------------
;; UUIDGEN
;; https://github.com/kanru/uuidgen-el
;; Generates uuids that are used as task references.

(use-package uuidgen
  :ensure t)

;;-------------------------------------------------------------------------------
