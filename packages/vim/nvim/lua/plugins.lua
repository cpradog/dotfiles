-- initialize package manager
local install_path = vim.fn.stdpath('data') ..
                       '/site/pack/packer/opt/packer.nvim'
if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system(
    { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  )
end

vim.cmd('packadd packer.nvim')
vim.cmd([[autocmd BufWritePost nvim/**/*.lua source <afile> | PackerCompile]])
local packer = require('packer')
packer.startup(
  {
    function(use)
      -- package manager
      use { 'wbthomason/packer.nvim', event = 'VimEnter' }
    end,
    config = {
      max_jobs = 50,
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end,
      },
    },
  }
)

