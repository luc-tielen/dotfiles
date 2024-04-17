-- Make error messages an easier to read color (same as in statusline):
vim.cmd [[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]]
vim.cmd [[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]]

-- Show document highlights
vim.cmd [[highlight link LspReferenceText Visual]]
vim.cmd [[highlight link LspReferenceRead Visual]]
vim.cmd [[highlight link LspReferenceWrite Visual]]
