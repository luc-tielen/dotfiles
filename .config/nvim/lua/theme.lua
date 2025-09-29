-- Make error messages an easier to read color (same as in statusline):
vim.cmd([[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]])
vim.cmd([[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]])

-- Show document highlights
vim.cmd([[highlight link LspReferenceText Visual]])
vim.cmd([[highlight link LspReferenceRead Visual]])
vim.cmd([[highlight link LspReferenceWrite Visual]])

-- Highlighting of current line number
vim.cmd("highlight clear CursorLine")
vim.cmd("highlight CursorLineNr guifg=#DDDD00")
vim.cmd("highlight LineNr guifg=#888888")
vim.cmd("highlight SignColumn guibg=#0F1419")

-- Better color in autocomplete menu
vim.cmd("highlight PmenuSel  ctermfg=0 ctermbg=11 guifg=NvimDarkGrey1 guibg=NvimLightYellow")
