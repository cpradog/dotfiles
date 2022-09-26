local use = require('packer').use

use { 'gko/vim-coloresque' }

use {
  'hail2u/vim-css3-syntax',
  config = function()
    vim.cmd [[
      augroup VimCSS3Syntax
        autocmd!
        autocmd FileType css setlocal iskeyword+=-
        autocmd BufRead,BufNewFile *.scss set filetype=scss.css
      augroup END

    ]]
  end,
}

use { 'cakebaker/scss-syntax.vim' }

use { 'stephenway/postcss.vim' }

require('util.lsp').lspconfig_setup(
  function(lspconfig)
    lspconfig.cssls.setup(
      {
        sourceName = 'cssls',
        on_attach = require('util.lsp').on_attach,
        filetypes = { 'css', 'scss', 'less' },
        settings = {
          css = { validate = true },
          less = { validate = true },
          scss = { validate = true },
        },
      }
    )

    lspconfig.stylelint_lsp.setup(
      {
        sourceName = 'stylelint',
        on_attach = require('util.lsp').on_attach,
        filetypes = { 'css', 'scss', 'less' },
        settings = {
          stylelintplus = {
            autoFixOnFormat = true,
            autoFixOnSave = true,
            validateOnType = true,
            validateOnSave = true,
          },
        },
      }
    )
  end
)
