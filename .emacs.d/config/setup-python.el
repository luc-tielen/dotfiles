
;; Add SConstruct and SConscript files to python mode (for syntax highlighting)

(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))

(provide 'setup-python)
