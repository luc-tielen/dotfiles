-- Config is based on this: https://github.com/kraftwerk28/dotfiles/blob/master/.config/nvim/lua/cfg/galaxyline.lua

local gl = require 'galaxyline'
local vcs = require('galaxyline.provider_vcs')
local utils = require 'utils'
local colors = require('statusline_colors')

local ERROR = 1
local WARNING = 2

local count_lsp_diagnostics = function(severity)
  local count = 0

  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    if diagnostic.severity == severity then
      count = count + 1
    end
  end

  return count
end

local count_lsp_warnings = function()
  return count_lsp_diagnostics(WARNING)
end

local count_lsp_errors = function()
  return count_lsp_diagnostics(ERROR)
end


local gls = gl.section
local u = utils.u

local mode_map = {
  ['n'] = {'NORMAL', colors.normal},
  ['i'] = {'INSERT', colors.insert},
  ['R'] = {'REPLACE', colors.replace},
  ['v'] = {'VISUAL', colors.visual},
  ['V'] = {'V-LINE', colors.visual},
  ['c'] = {'COMMAND', colors.command},
  ['s'] = {'SELECT', colors.visual},
  ['S'] = {'S-LINE', colors.visual},
  ['t'] = {'TERMINAL', colors.terminal},
  [''] = {'V-BLOCK', colors.visual},
  [''] = {'S-BLOCK', colors.visual},
  ['Rv'] = {'VIRTUAL'},
  ['rm'] = {'--MORE'},
}

local sep = {
  right_filled = u 'e0b2',
  left_filled = u 'e0b0',
  right = u 'e0b3',
  left = u 'e0b1',
}

-- Look up unicode values here: https://github.com/just3ws/nerd-font-cheatsheets
local icons = {
  locker = u 'f023',
  unsaved = u 'f693',
  lsp_warn = u 'f071',
  lsp_error = u 'f00d',
  git = u 'e725'
}

local function mode_label() return mode_map[vim.fn.mode()][1] or 'N/A' end
local function mode_hl() return mode_map[vim.fn.mode()][2] or colors.none end

local function highlight(group, fg, bg, gui)
  local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
  if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
  vim.cmd(cmd)
end

local function buffer_not_empty()
  return vim.fn.empty(vim.fn.expand '%:t') ~= 1
end

gl.short_line_list = {'NvimTree'}
gls.left = {
  {
    ViMode = {
      provider = function()
        local modehl = mode_hl()
        highlight('GalaxyViMode', colors.bg, modehl, 'bold')
        highlight('GalaxyViModeInv', modehl, colors.bg, 'bold')
        return string.format('  %s ', mode_label())
      end,
      separator = sep.left_filled,
      separator_highlight = 'GalaxyViModeInv',
    }
  },
  {
    FileName = {
      condition = buffer_not_empty,
      provider = function()
        if not buffer_not_empty() then return '' end
        local fname = vim.fn.expand '%:t'
        if #fname == 0 then return '' end
        if vim.bo.readonly then fname = fname .. ' ' .. icons.locker end
        if vim.bo.modified then fname = fname .. ' ' .. icons.unsaved end
        return ' ' .. fname .. ' '
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.left,
      separator_highlight = 'GalaxyViModeInv',
    }
  }
}

gls.right = {
  {
    LspStatus = {
      provider = function()
        local connected = not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
        if connected then
          return ' ' .. u 'f0e7' .. ' '
        else
          return ''
        end
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = 'GalaxyViModeInv',
    }
  },
  {
    DiagnosticWarn = {
      provider = function()
        local n = count_lsp_warnings()
        if n == 0 then return '' end
        return string.format(' %s %d ', icons.lsp_warn, n)
      end,
      highlight = {colors.lsp_warning, colors.bg},
    }
  },
  {
    DiagnosticError = {
      provider = function()
        local n = count_lsp_errors()
        if n == 0 then return '' end
        return string.format(' %s %d ', icons.lsp_error, n)
      end,
      highlight = {colors.lsp_error, colors.bg},
    }
  },
  {
    GitInfo = {
      provider = function()
        -- TODO make branch more robust, builtin is kind of "flaky"
        local branch = vcs.get_git_branch() or ''
        return string.format(' %s %s', icons.git, branch)
      end,
      condition = buffer_not_empty and vcs.check_git_workspace,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = 'GalaxyViModeInv',
    },
  },
  {
    PositionInfo = {
      provider = {
        function()
          return string.format('%s:%s', vim.fn.line('.'), vim.fn.col('.'))
        end,
      },
      highlight = 'GalaxyViMode',
      separator = sep.right_filled,
      separator_highlight = 'GalaxyViModeInv',
    },
  }
}

for k, v in pairs(gls.left) do gls.short_line_left[k] = v end
table.remove(gls.short_line_left, 1)

for k, v in pairs(gls.right) do gls.short_line_right[k] = v end
table.remove(gls.short_line_right)
table.remove(gls.short_line_right)
