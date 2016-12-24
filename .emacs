
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Enable evil mode (vim bindings)
(require 'evil)
(evil-mode 1)

;; GUI related settings
(load-theme 'tangotango t)
;;(set-default-font "Inconsolata-g-12")
(setq inhibit-startup-message t)  ;; disables startup screen
;; disable toolbars / scrollbar:
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(global-linum-mode 1)  ;; Line numbers

;; Powerline / Spaceline
(require 'powerline)
(require 'spaceline-config)
(spaceline-emacs-theme)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
(setq powerline-height 25)
(spaceline-helm-mode)

;; Enable Lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 2)

;; Smooth scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

;; Disable autosave and backup
(setq auto-save-default nil)
(setq make-backup-files nil)


;; TODO flycheck, magit, ... (plugins)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9864c2e956c25b3098fbc935ba0969e333dd74ecd7a1013c8dd39a6c171e1cca" "86a731bda96ed5ed69980b4cbafe45614ec3c288da3b773e4585101e7ece40d2" "e8586a76a96fd322ccb644ca0c3a1e4f4ca071ccfdb0f19bef90c4040d5d3841" "beeb5ac6b65fcccfe434071d4624ff0308b5968bf2f0c01b567d212bcaf66054" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "cadc97db0173a0d0bfc40473cab4da462af0ba8d60befd0a4879b582bcbc092d" "aab598c4d024d544b4e8b356a95ca693afa9de000b154bd2f86eed68c9e75557" "8f0334c430540bf45dbcbc06184a2e8cb01145f0ae1027ce6b1c40876144c0c9" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "4f0f2f5ec60a4c6881ba36ffbfef31b2eea1c63aad9fe3a4a0e89452346de278" "a164837cd2821475e1099911f356ed0d7bd730f13fa36907895f96a719e5ac3e" "c4a784404a2a732ef86ee969ab94ec8b8033aee674cd20240b8addeba93e1612" "e8a976fbc7710b60b069f27f5b2f1e216ec8d228fe5091f677717d6375d2669f" "222113f148cd70d99c44d84bf4e3a76795f001bd6cfd449b7ff27aeda65ffd78" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
