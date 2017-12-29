
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
(require 'setup-erlang)
(require 'setup-elixir)
(require 'setup-elm)
(require 'setup-julia)
(require 'setup-docker)
(require 'setup-yaml)
(require 'setup-mmm)
(require 'setup-markdown)

;; TODO flymake, magit, ... (plugins)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4980e5ddaae985e4bae004280bd343721271ebb28f22b3e3b2427443e748cd3f" "0b6cb9b19138f9a859ad1b7f753958d8a36a464c6d10550119b2838cedf92171" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "53a9ec5700cf2bb2f7059a584c12a5fdc89f7811530294f9eaf92db526a9fb5f" "a4c9e536d86666d4494ef7f43c84807162d9bd29b0dfd39bdf2c3d845dcc7b2e" default)))
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
    (noctilux-theme grandshell-theme atom-dark-theme atom-one-dark-theme company-c-headers helm-projectile projectile helm-swoop helm-grepint use-package helm sublime-themes opencl-mode tangotango-theme spaceline smooth-scrolling paradox lua-mode haskell-mode flycheck evil-space evil-search-highlight-persist evil-magit evil-leader color-theme-sanityinc-tomorrow)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
