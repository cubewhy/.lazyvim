local M = {}
function M.IsNixOS()
  local f = io.open("/run/current-system/sw", "r")
  local libFolder = io.open("/usr/lib", "r")
  if f and not libFolder then
    f:close()
    return true
  end
  if libFolder then
    libFolder:close()
  end
  return false
end

return M
