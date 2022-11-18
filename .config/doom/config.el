;; a header could go here
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Antoine Stevan"
      user-mail-address "stevan.antoine@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "mononoki Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "mononoki Nerd Font Mono" :size 20)
      doom-big-font (font-spec :family "mononoki Nerd Font Mono" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq modus-themes-mode-line '(accented borderless)
      modus-themes-region '(bg-only)
      modus-themes-completions 'opinionated
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-paren-match '(bold intense underline)
      ;; modus-themes-syntax '(alt-syntax)
      ;; modus-themes-syntax '(alt-syntax faint)
      modus-themes-syntax '(green-strings yellow-comments)
      modus-themes-headings
      '((1 . (rainbow background overline 1.4))
        (2 . (rainbow background 1.3))
        (3 . (rainbow bold 1.2))
        (t . (semilight 1.1)))
      modus-themes-scale-headings t
      modus-themes-org-blocks 'tinted-background)
(load-theme 'modus-vivendi t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/ghq/github.com/amtoine/org-files/")
;; enabling org bullet points.
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; better dired configuration.
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
        "h" 'dired-single-up-directory
        "l" 'dired-single-buffer))
(use-package dired-single)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
        "H" 'dired-hide-dotfiles-mode))

;; add a beacon when moving around
(beacon-mode 1)

;; a minimap for long files
(setq minimap-window-location 'right)
(setq minimap-width-fraction 0.1)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

;; some help support with clippy on c h
(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
       :desc "Clippy describes function under point" "f" #'clippy-describe-function
       :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

;; IRC support
(setq erc-prompt (lambda () (concat "[" (buffer-name) "]"))
      erc-server "irc.libera.chat"
      erc-nick "astevan"
      erc-user-full-name "Antoine Stevan"
      erc-auto-query 'bury
      erc-fill-column 100
      erc-fill-function 'erc-fill-static
      erc-fill-static-center 20)

;; mail support
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'smtpmail)
(use-package mu4e
  :ensure t
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  (setq mu4e-get-mail-command "mbsync -a -c ~/.config/mu4e/mbsyncrc")
  (setq mu4e-root-maildir "~/mail")
  (setq mu4e-attachment-dir "~/dl")

  (setq mu4e-contexts
        (list
         ;; Main account
         (make-mu4e-context
          :name "Main"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/gmail/stevan.antoine" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "stevan.antoine@gmail.com")
                  (user-full-name    . "Antoine Stevan")
                  (mu4e-drafts-folder  . "/gmail/stevan.antoine/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/gmail/stevan.antoine/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/gmail/stevan.antoine/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/gmail/stevan.antoine/[Gmail]/Trash")))
         ;; Second account
         (make-mu4e-context
          :name "Second"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/gmail/antoineulk17" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "antoineulk17@gmail.com")
                  (user-full-name    . "Antoine Stevan")
                  (mu4e-drafts-folder  . "/gmail/antoineulk17/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/gmail/antoineulk17/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/gmail/antoineulk17/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/gmail/antoineulk17/[Gmail]/Trash")))
         ;; instadeep account
         (make-mu4e-context
          :name "Instadeep"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/gmail/instadeep" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "a.stevan@instadeep.com")
                  (user-full-name    . "Antoine Stevan (Instadeep)")
                  (mu4e-drafts-folder  . "/gmail/instadeep/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/gmail/instadeep/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/gmail/instadeep/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/gmail/instadeep/[Gmail]/Trash")))
         ;; supaero account
         (make-mu4e-context
          :name "Supaero"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/isae/supaero" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "antoine.stevan@student.isae-supearo.fr")
                  (user-full-name    . "Antoine Stevan (ISAE-Supaero)")
                  (mu4e-drafts-folder  . "/isae/supaero/Drafts")
                  (mu4e-sent-folder  . "/isae/supaero/Sent")
                  (mu4e-refile-folder  . "/isae/supaero/Junk")
                  (mu4e-trash-folder  . "/isae/supaero/Trash")))))

  (setq mu4e-maildir-shortcuts
      '(("/gmail/stevan.antoine/Inbox"             . ?i)
        ("/gmail/stevan.antoine/[Gmail]/Sent Mail" . ?s)
        ("/gmail/stevan.antoine/[Gmail]/Trash"     . ?t)
        ("/gmail/stevan.antoine/[Gmail]/Drafts"    . ?d)
        ("/gmail/stevan.antoine/[Gmail]/All Mail"  . ?a)))

  (setq mu4e-compose-signature
        (concat
         "Antoine\n\n"
         "amtoine on GitHub\n"
         "antoine#1306 on discord"))

  (setq mml-secure-openpgp-signers '("ACBC686587C0B5C602A183F7B3A3111EF03B47C2"))
  (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

  (setq smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 465
        smtpmail-stream-type 'ssl)
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-user "stevan.antoine@gmail.com")
  (mu4e t))
