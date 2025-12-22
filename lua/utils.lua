local M = {}
function M.IsNixOS()
  local f = io.open("/run/current-system/sw", "r")
  if f then
    f:close()
    return true
  end
  return false
end

return M
