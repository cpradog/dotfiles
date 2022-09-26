local use = require('packer').use
local lsp = require('util.lsp')
local debugger = require('util.debugger')

use {
  'octol/vim-cpp-enhanced-highlight',
  config = function()
    vim.g.cpp_member_variable_highlight = 1
    vim.g.cpp_class_decl_highlight = 1
    vim.g.cpp_experimental_template_highlight = 1
    vim.g.cpp_concepts_highlight = 1
  end,
}

use { 'pboettch/vim-cmake-syntax' }

use {
  'ilyachur/cmake4vim',
  config = function()
    vim.g.cmake_reload_after_save = 1
    vim.g.cmake_build_dir = 'build'
    vim.g.cmake_compile_commands = 1
    vim.g.cmake_compile_commands_link = '.'
    vim.g.make_arguments = '-j20'
    vim.g.cmake_usr_args = ''
  end,
}

use { 'igankevich/mesonic' }

lsp.lspconfig_setup(
  function(lspconfig)
    lspconfig.ccls.setup(
      {
        on_attach = require('util.lsp').on_attach,
        filetypes = { 'cpp', 'c', 'cpp.doxygen', 'c.doxygen' },
        init_options = {
          cache = { directory = '/home/cpradog/.cache/ccls' },
          highlight = { lsRanges = true },
          index = { onChange = true },
          diagnostics = { onOpen = 1000 },
        },
        settings = {},
      }
    )

    lspconfig.cmake.setup({ on_attach = require('util.lsp').on_attach })
  end
)

vim.cmd(
  [[
    augroup cpp
      autocmd!
      autocmd BufNewFile,BufReadPost,FileReadPost *.cpp,*.cc,*.h,*.hpp,*.hxx set filetype=cpp.doxygen
      autocmd BufNewFile,BufReadPost,FileReadPost .clang-format set filetype=yaml.clang-format
    augroup END
  ]]
)

debugger.add_adapter(
  'lldb',
  { name = 'lldb', type = 'executable', command = '/usr/bin/lldb-vscode' }
)

debugger.add_configuration(
  { 'c', 'cpp', 'cpp.doxygen', 'c.doxygen' }, {
    {

      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Executable path: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runOnTerminal = false,
      env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format('%s=%s', k, v))
        end
        return variables
      end,
    },
  }
)

