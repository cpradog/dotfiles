local use = require('packer').use

use {
  'hashivim/vim-terraform',
  config = function()
    vim.g.terraform_align = 1
    vim.g.terraform_fold_sections = 0
    vim.g.terraform_fmt_on_save = 1
  end,
}

require('util.lsp').lspconfig_setup(
  function(lspconfig)
    lspconfig.terraformls.setup({ on_attach = require('util.lsp').on_attach })
  end
)
