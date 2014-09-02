;; flycheck
(add-to-list 'load-path "~/Projects/Go/src/github.com/dougm/goflymake")
(require 'go-flymake)

;; auto-completion
(require 'go-autocomplete)
(require 'auto-complete-config)

;; documentation
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; configuration
(add-hook 'go-mode-hook
          '(lambda()
             (setq c-basic-offset 4)
             (setq tab-width 4)
             (setq indent-tabs-mode t)
             (local-set-key (kbd "M-.") 'godef-jump)
             (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
             (local-set-key (kbd "C-c i") 'go-goto-imports)
             (local-set-key (kbd "C-c d") 'godoc)))

(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'wunki-go)