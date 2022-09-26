local option = vim.opt
local use = require('packer').use

-- use patience algorithm for diff
option.diffopt:append('internal,algorithm:patience')

-- mergetool
use 'whiteinge/diffconflicts'

-- improve diff algorithm
use {
  'chrisbra/vim-diff-enhanced',
  config = function()
    vim.cmd [[
      if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
      endif
    ]]
  end,
}
