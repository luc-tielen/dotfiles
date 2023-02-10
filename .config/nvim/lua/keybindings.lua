-- Disable arrow keys and shift + arrow keys (forces hjkl):
for _, key in ipairs({'<up>', '<down>', '<left>', '<right>',
                      '<S-up>', '<S-down>', '<S-left>', '<S-right>'}) do
  for _, mode in ipairs({'n', 'i'}) do
    vim.keymap.set(mode, key, '<nop>')
  end
end

-- Shift + H / L for quicker navigation (J already joins lines, K does nothing)
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'K', '<nop>')
vim.keymap.set('', 'L', 'g_')

-- Alt + J/K to move line(s) down/up
if vim.fn.has('macunix') == '1' then
  -- OSX needs to be special..
  vim.keymap.set('n', '�', ':m .+1<CR>==', {noremap = true})
  vim.keymap.set('n', '�', ':m .-2<CR>==', {noremap = true})
  vim.keymap.set('i', '�', '<Esc>:m .+1<CR>==gi', {noremap = true})
  vim.keymap.set('i', '�', '<Esc>:m .-2<CR>==gi', {noremap = true})
  vim.keymap.set('v', '�', ':m \'>+1<CR>gv=gv', {noremap = true})
  vim.keymap.set('v', '�', ':m \'<-2<CR>gv=gv', {noremap = true})
else
  vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {noremap = true})
  vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {noremap = true})
  vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {noremap = true})
  vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {noremap = true})
  vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {noremap = true})
  vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {noremap = true})
end

-- Ctrl + HJKL for navigating across buffers/windows
vim.keymap.set('', '<C-h>', '<C-w><left>', {noremap = true})
vim.keymap.set('', '<C-j>', '<C-w><down>', {noremap = true})
vim.keymap.set('', '<C-k>', '<C-w><up>', {noremap = true})
vim.keymap.set('', '<C-l>', '<C-w><right>', {noremap = true})

-- No need for ex mode
vim.keymap.set('n', 'Q', '<nop>', {noremap = true})

-- Neovim terminal mapping
-- terminal 'normal mode'
vim.keymap.set('t', '<esc>', '<c-\\><c-n><esc><cr>')

-- Copy to OSX clipboard (only enable on OSX)
if vim.fn.has('macunix') == '1' then
  vim.keymap.set('v', '<C-c>', '"*y<CR>', {noremap = true})
  vim.keymap.set('v', 'y', '"*y<CR>', {noremap = true})
end

vim.keymap.set('', 'Y', 'y$', {noremap = true})

-- Better regexes:
vim.keymap.set('n', '/', '/\\v', {noremap = true})
vim.keymap.set('n', '/', '/\\v', {noremap = true})

-- Disable highlight after search with enter
vim.keymap.set('n', '<cr>', ':noh<cr><cr>', {silent = true, noremap = true})
-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
-- vim.cmd [[ nnoremap <silent> <expr> <CR> {-> v:hlsearch ? "<cmd>nohl\<CR>" : "\<CR>"}() ]]

-- Use tab in normal/visual mode to go to matching brackets:
vim.keymap.set('n', '<tab>', '%', {noremap = true})
vim.keymap.set('v', '<tab>', '%', {noremap = true})

-- Center screen when jumping around
vim.keymap.set('n', 'n', 'nzz', {noremap = true})
vim.keymap.set('v', 'n', 'nzz', {noremap = true})
vim.keymap.set('n', 'N', 'Nzz', {noremap = true})
vim.keymap.set('v', 'N', 'Nzz', {noremap = true})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {noremap = true})
vim.keymap.set('v', '<C-u>', '<C-u>zz', {noremap = true})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {noremap = true})
vim.keymap.set('v', '<C-d>', '<C-d>zz', {noremap = true})

-- Easier autocompletion menu navigation

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Telescope bindings:
vim.keymap.set('n', '<C-p>', ':Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>', {noremap = true})
vim.keymap.set('n', '<leader>p', ':Telescope projects<cr>', {noremap = true})
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<cr>', {noremap = true})
vim.keymap.set('n', '<leader>*', '*#:Telescope grep_string<cr>', {noremap = true})
vim.keymap.set('n', '<leader>b', ':Telescope git_branches<cr>', {noremap = true})
vim.keymap.set('n', '<leader>d', ':Telescope diagnostics<cr>', {noremap = true})
vim.keymap.set('n', '<leader>a', ':lua vim.lsp.buf.code_action()<cr>', {noremap = true})
--vim.keymap.set('n', '<leader>h', ':Telescope hoogle<cr>', {noremap = true})

-- git-messenger bindings:
-- Note: do 'gm' again to go into popup, list all actions using '?'
vim.keymap.set('n', 'gm', ':GitMessenger<CR>', {noremap = true})

-- Execute current line / file (only for Lua)
vim.keymap.set('n', '<leader>x', ':lua execute_current_line()<cr>', {noremap = true})
vim.keymap.set('n', '<leader>xf', ':lua execute_current_file()<cr>', {noremap = true})

-- Run tests using my client.sh / server.sh gist
vim.keymap.set('n', '<leader>t', ':!client.sh<cr><cr>', {noremap = true})

-- Space (leader) does nothing in normal or visual mode
vim.keymap.set({'n', 'v'}, '<space>', '<nop>', {silent = true})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Autocommands:

-- Highlight region on yank (temporarily)
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})
