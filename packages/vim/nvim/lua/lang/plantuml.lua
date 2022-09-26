local use = require('packer').use

use {
  'aklt/plantuml-syntax',
  config = function()
    vim.g.plantuml_executable_script = '/usr/bin/plantuml'
    vim.g.plplantuml_set_makeprg = 1
  end,
}
