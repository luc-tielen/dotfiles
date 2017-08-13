
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/config")

(require 'setup-general)
(require 'setup-helm)
(require 'setup-helm-gtags)
(require 'setup-evil-mode)
(require 'setup-spaceline)
(require 'setup-cedet)
(require 'setup-c)
(require 'setup-sh)
(require 'setup-lua)
(require 'setup-python)
(require 'setup-haskell)
(require 'setup-rust)
(require 'setup-elixir)
(require 'setup-julia)
(require 'setup-docker)


;; TODO flymake, magit, ... (plugins)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "9864c2e956c25b3098fbc935ba0969e333dd74ecd7a1013c8dd39a6c171e1cca" "86a731bda96ed5ed69980b4cbafe45614ec3c288da3b773e4585101e7ece40d2" "e8586a76a96fd322ccb644ca0c3a1e4f4ca071ccfdb0f19bef90c4040d5d3841" "beeb5ac6b65fcccfe434071d4624ff0308b5968bf2f0c01b567d212bcaf66054" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "cadc97db0173a0d0bfc40473cab4da462af0ba8d60befd0a4879b582bcbc092d" "aab598c4d024d544b4e8b356a95ca693afa9de000b154bd2f86eed68c9e75557" "8f0334c430540bf45dbcbc06184a2e8cb01145f0ae1027ce6b1c40876144c0c9" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "4f0f2f5ec60a4c6881ba36ffbfef31b2eea1c63aad9fe3a4a0e89452346de278" "a164837cd2821475e1099911f356ed0d7bd730f13fa36907895f96a719e5ac3e" "c4a784404a2a732ef86ee969ab94ec8b8033aee674cd20240b8addeba93e1612" "e8a976fbc7710b60b069f27f5b2f1e216ec8d228fe5091f677717d6375d2669f" "222113f148cd70d99c44d84bf4e3a76795f001bd6cfd449b7ff27aeda65ffd78" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(haskell-mode-hook
   (quote
    (flyspell-prog-mode haskell-indentation-mode interactive-haskell-mode)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(haskell-tags-on-save t)
 '(package-selected-packages
   (quote
    (company-c-headers helm-projectile projectile helm-swoop helm-grepint use-package helm sublime-themes opencl-mode tangotango-theme spaceline smooth-scrolling paradox lua-mode haskell-mode flycheck evil-space evil-search-highlight-persist evil-magit evil-leader color-theme-sanityinc-tomorrow)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
