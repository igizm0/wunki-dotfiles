;; load and fire
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'sendmail)
(require 'org-mu4e)

;; my e-mail addresses
(setq mu4e-user-mail-address-list '("petar@wunki.org"
                                    "petar@gibbon.co"
                                    "petar@breadandpepper.com"
                                    "hello@breadandpepper.com"))

;; general settings
(setq mail-user-agent 'mu4e-user-agent                   ; mu4e as default mail agent
      mu4e-attachment-dir "~/downloads"                  ; put attachements in download dir
      mu4e-get-mail-command "offlineimap"                ; fetch email with offlineimap
      mu4e-confirm-quit nil                              ; don't ask me to quit
      mu4e-headers-date-format "%d %b, %Y at %H:%M"      ; date format
      message-signature "Petar Radosevic | @wunki"       ; signature
      message-kill-buffer-on-exit t                      ; don't keep message buffers around
      mu4e-headers-leave-behavior 'apply                 ; apply all marks at quit
      mu4e-html2text-command "html2text -utf8 -width 72" ; html to text
      smtpmail-queue-mail nil                            ; start in non queue mode
      mu4e-compose-dont-reply-to-self t                  ; don't reply to myself please
)

;; maildir locations
(setq mu4e-maildir "/home/wunki/mail"
      mu4e-sent-folder "/wunki/sent"
      mu4e-drafts-folder "/wunki/drafts"
      mu4e-trash-folder "/wunki/trash"
      mu4e-refile-folder "/wunki/archive"
      smtpmail-queue-dir   "~/mail/queue/cur")

;; sending mail
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)

;; multiple accounts
(setq wunki-mu4e-account-alist
      '(("wunki"
         (user-mail-address "petar@wunki.org")
         (mu4e-sent-folder "/wunki/sent")
         (mu4e-drafts-folder "/wunki/drafts")
         (mu4e-refile-folder "/wunki/archive")
         (mu4e-trash-folder  "/wunki/trash")
         (smtpmail-smtp-server "mail.messagingengine.com")
         (smtpmail-smtp-user "wunki@fastmail.fm"))
        ("bread-and-pepper"
         (user-mail-address "petar@breadandpepper.com")
         (mu4e-sent-folder "/bread-and-pepper/sent")
         (mu4e-drafts-folder "/bread-and-pepper/drafts")
         (mu4e-refile-folder "/bread-and-pepper/archive")
         (mu4e-trash-folder  "/bread-and-pepper/trash")
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-user "petar@breadandpepper.com"))
        ("gibbon"
         (user-mail-address "petar@gibbon.co")
         (mu4e-sent-folder "/gibbon/sent")
         (mu4e-drafts-folder "/gibbon/drafts")
         (mu4e-refile-folder "/gibbon/archive")
         (mu4e-trash-folder  "/gibbon/trash")
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-user "petar@gibbon.co"))))

(defun wunki-mu4e-set-account ()
  "Set the account for composing a message by looking at the maildir"
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-msg-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) wunki-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) wunki-mu4e-account-alist)
                             nil t nil nil (caar wunki-mu4e-account-alist))))
         (account-vars (cdr (assoc account wunki-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars))))
(add-hook 'mu4e-compose-pre-hook 'wunki-mu4e-set-account)

;; org-mode integration
(setq mu4e-org-contacts-file "/home/wunki/org/contacts.org")
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)

;; headers
(setq mu4e-headers-fields
  '((:maildir       .   8) 
    (:date          .  24)
    (:flags         .   6)
    (:from          .  24)
    (:subject       .  nil)))

;; set bookmarks
(setq mu4e-bookmarks 
  '(("flag:new maildir:/gibbon/inbox"             "New Bread & Pepper"   ?g)
    ("flag:new maildir:/wunki/inbox"              "New Personal"         ?p)
    ("flag:new maildir:/bread-and-pepper/inbox"   "New Bread & Pepper"   ?b)
    ("flag:unread maildir:/wunki/inbox OR maildir:/bread-and-pepper/inbox OR maildir:/gibbon/inbox"  "All unread messages"  ?u)
    ("date:today..now"                            "Today's messages"     ?t)
    ("date:7d..now"                               "Last 7 days"          ?w)
    ("mime:image/*"                               "Messages with images" ?i)
    ("flag:flagged"                               "Flagged messages"     ?f)))

;; shortcuts
(setq mu4e-maildir-shortcuts
       '(("/wunki/inbox"              . ?i)
         ("/bread-and-pepper/inbox"   . ?I)
         ("/wunki/archive"            . ?a)
         ("/bread-and-pepper/archive" . ?A)
         ("/wunki/sent"               . ?s)
         ("/bread-and-pepper/sent"    . ?S)
         ("/wunki/trash"              . ?t)
         ("/bread-and-pepper/trash"   . ?T)
         ("/wunki/clojure"            . ?c)
         ("/wunki/haskell-beginners"  . ?h)
         ("/wunki/rust-development"   . ?r)))
