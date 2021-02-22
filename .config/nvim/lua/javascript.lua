-- Javascript-specific config

vim.cmd [[
let g:jsx_ext_required = 0

let g:prettier#autoformat = 0
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'false'

autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.json PrettierAsync
]]
