local use = require('packer').use

-- function Mail_setup()
-- autocmd FileType mail noremap <LocalLeader>m :call vimmail#sendmail#Sendmail()<CR>
-- autocmd FileType mail map <silent><LocalLeader>M  :call VimMailStartClientRO() <CR>
-- autocmd FileType mail map <silent><LocalLeader>F :call vimmail#switchFrom() <CR>
-- autocmd FileType mail map <silent><LocalLeader>f :call VimMailGoto('/^From','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>b :call VimMailGoto('/^Bcc','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>c :call VimMailGoto('/^Cc','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>s :call VimMailGoto('/^Subject','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>R :call VimMailGoto('/^Reply-To','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>t :call VimMailGoto('/^To','A') <CR>
-- autocmd FileType mail map <silent><LocalLeader>r :call VimMailGoto('/^>','I') <CR>
-- autocmd FileType mail map <silent><LocalLeader>r2 :call VimMailGoto('/^>\s*>','I') <CR>
-- autocmd FileType mail map <silent><LocalLeader>r3 :call VimMailGoto('/^>\s*>\s*>','I') <CR>
-- autocmd FileType mail map <silent><LocalLeader>r4 :call VimMailGoto('/^>\s*>\s*>\s*>','I') <CR>
-- autocmd FileType mail map <silent><LocalLeader>S :call VimMailGoto('/^-- ','j') <CR>
-- autocmd FileType mail map <silent><LocalLeader>B :call VimMailGoto('/^$','I') <CR>
-- autocmd FileType mail map <silent><LocalLeader>E :call VimMailGoto('/^>','Nj') <CR>
-- autocmd FileType mail map <silent><LocalLeader>kqs :call VimMailKillQuotedSig() <CR>
-- autocmd FileType mail imap <silent><localLeader>a <C-X><C-O>
-- autocmd FileType mail nmap <silent><localLeader>a :call vimmail#contacts#sync()<CR>
-- end

use {
  'dbeniamine/vim-mail',
  disable = true,
  config = function()
    vim.g.VimMailStartFlags =
      { blank = 'TAi', nosubject = 'SAi', default = 't' }
    vim.g.VimMailSpellLangs = {}
    vim.g.VimMailFromList = {
      'Carlos Prado <carlos.prado@cpradog.com>',
      'Carlos Prado <carlos.prado@mad.vass.es>',
    }

    vim.g.VimMailContactsProvider = { 'khard' }
    vim.g.VimMailClient = 'neomutt'
    vim.g.VimMailDoNotMap = 1

    -- vim.cmd [[
    --   autocmd FileType mail <silent> <Cmd>call v:lua._mail_setup()<CR>
    -- ]]
  end,
}
