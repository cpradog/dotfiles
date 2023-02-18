set folder    = '~/.local/mail/cpradog'
set mbox_type = 'Maildir'
set spoolfile = '+Inbox'
set record    = '+Sent'
set postponed = '+Drafts'
set trash     = '+Trash'

mailboxes ! +Archive +Drafts +Sent +Spam +Trash

set realname      = 'Carlos Prado Garcia'
set from          = 'carlos.prado@cpradog.com'
set sendmail      = '/usr/bin/msmtp'
set use_from      = yes
set envelope_from = yes
set ssl_force_tls = yes
set delete        = yes

# alternate email addresses
alternates -group me \
           cpradog@gmail.com \
           cpradog@me.com \
           cpradog@icloud.com \
           carlos.prado@cpradog.com \
           carlos.prado@mad.vass.es
