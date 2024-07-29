local M = {}

--- This proxies a command through `sail` if it is installed.
---
--- @param cmd string
--- @param as_string boolean
--- @return string|string[]
function M.sail_or_bin(cmd, as_string)
  local sail = './vendor/bin/sail'

  if vim.fn.executable(sail) == 1 then
    local result = { sail, 'bin', cmd }
    if as_string then return table.concat(result, ' ') end

    return result
  end

  return './vendor/bin/' .. cmd
end

return M
