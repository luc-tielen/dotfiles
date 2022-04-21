local u = require 'utils'

local function map(mode, opts)
  local function do_map(lhs, rhs, extra_opts)
    local options = u.merge(opts, extra_opts or {})
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  return do_map
end

local nremap = map('n', {noremap = false})
local vremap = map('v', {noremap = false})
local nnoremap = map('n', {noremap = true})
local inoremap = map('i', {noremap = true})
local vnoremap = map('v', {noremap = true})
local snoremap = map('s', {noremap = true})
local noremap = map('', {noremap = true})
local tmap = map('t', {noremap = false})

-- Disable arrow keys (forces hjkl):
for _, key in ipairs({'<up>', '<down>', '<left>', '<right>'}) do
  nnoremap(key, '<nop>')
  inoremap(key, '<nop>')
end

-- Disable shift + arrow keys:
for _, key in ipairs({'<S-up>', '<S-down>', '<S-left>', '<S-right>'}) do
  nnoremap(key, '<nop>')
  inoremap(key, '<nop>')
end

-- Shift + HJKL for quicker navigation
noremap('H', '^')
--noremap('J', '5j')
--noremap('K', '5k')
noremap('L', 'g_')

-- Alt + J/K to move line(s) down/up
nnoremap('<A-j>', ':m .+1<CR>==')
nnoremap('<A-k>', ':m .-2<CR>==')
inoremap('<A-j>', '<Esc>:m .+1<CR>==gi')
inoremap('<A-k>', '<Esc>:m .-2<CR>==gi')
vnoremap('<A-j>', ':m \'>+1<CR>gv=gv')
vnoremap('<A-k>', ':m \'<-2<CR>gv=gv')

-- Ctrl + HJKL for navigating across buffers/windows
noremap('<C-h>', '<C-w><left>')
noremap('<C-j>', '<C-w><down>')
noremap('<C-k>', '<C-w><up>')
noremap('<C-l>', '<C-w><right>')

-- No need for ex mode
nnoremap('Q', '<nop>')

-- Neovim terminal mapping
-- terminal 'normal mode'
tmap('<esc>', '<c-\\><c-n><esc><cr>')

-- Copy to OSX clipboard
vnoremap('<C-c>', '"*y<CR>')
vnoremap('y', '"*y<CR>')
noremap('Y', 'y$')

-- Faster escape out of insert mode:
--inoremap('jj', '<ESC>')

-- Better regexes:
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Disable highlight after search with enter
nnoremap('<cr>', ':noh<cr><cr>', {silent = true})

-- Use tab in normal/visual mode to go to matching brackets:
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- Bindings for comment plugin
nremap('<leader>/', "gcc")
vremap('<leader>/', "gc")

-- Easier autocompletion menu navigation

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  --elseif vim.fn.call("vsnip#available", {1}) == 1 then
  --  return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  --elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  --  return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

inoremap('<Tab>', 'v:lua.tab_complete()', {expr = true})
snoremap('<Tab>', 'v:lua.tab_complete()', {expr = true})
inoremap('<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
snoremap('<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

-- Telescope bindings:
nnoremap('<C-p>', ':Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>')
nnoremap('<leader>g', ':Telescope live_grep<cr>')
nnoremap('<leader>*', '*#:Telescope grep_string<cr>')
nnoremap('<leader>b', ':Telescope git_branches<cr>')
nnoremap('<leader>t', ':Telescope treesitter<cr>')
nnoremap('<leader>a', ':Telescope lsp_code_actions<cr>')
nnoremap('<leader>d', ':Telescope diagnostics<cr>')
--nnoremap('<leader>h', ':Telescope hoogle<cr>')

-- compe bindings:
inoremap('<C-Space>', 'compe#complete()', {silent = true, expr = true})
inoremap('<CR>', "compe#confirm('<CR>')", {silent = true, expr = true})

-- git-messenger bindings:
-- Note: do 'gm' again to go into popup, list all actions using '?'
nnoremap('gm', ':GitMessenger<CR>')

-- Execute current line / file (only for Lua)
nnoremap('<leader>x', ':lua execute_current_line()<cr>')
nnoremap('<leader>xf', ':lua execute_current_file()<cr>')
