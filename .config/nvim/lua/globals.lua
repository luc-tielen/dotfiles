P = function(value)
  print(vim.inspect(value))
  return value
end

R = function(pkg_name)
  require('plenary_reload').reload_module(pkg_name)
end

execute_current_line = function()
  if vim.bo.filetype == 'lua' then
    local line = vim.fn.line('.') - 1
    local current_line = vim.api.nvim_buf_get_lines(
      0, line, line + 1, false)[1]
    vim.cmd(string.format('lua %s', current_line))
  end
end

execute_current_file = function()
  vim.cmd('luafile %')
end

