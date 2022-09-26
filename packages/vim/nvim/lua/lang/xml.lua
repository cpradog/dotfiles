local use = require('packer').use
local lsp = require('util.lsp')

use 'valloric/matchtagalways'

-- let g:neoformat_xml_tidy = {
--       \ 'exe': 'tidy',
--       \ 'args': ['-quiet',
--       \   '-xml',
--       \   '--indent auto',
--       \   '--indent-spaces ' . shiftwidth(),
--       \   '--vertical-space no',
--       \   '--indent-attributes',
--       \   '--indent-cdata',
--       \   '--accessibility-check 2',
--       \   '--sort-attributes',
--       \   '--add-xml-decl',
--       \   '--output-xml'
--       \ ],
--       \ 'stdin': 1,
--       \ }

-- let g:neoformat_xml_xmlstarlet = {
--       \ 'exe': 'xmlstarlet',
--       \ 'args': [
--       \   'fo',
--       \   '--indent-spaces ' . shiftwidth(),
--       \ ],
--       \ 'stdin': 1,
--       \ }

-- let g:neoformat_enabled_xml = ['xmlstarlet', 'tidy']
