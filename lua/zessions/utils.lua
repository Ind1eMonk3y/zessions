local strfmt = string.format
local Path = require("plenary.path")

local config = require("zessions.config")


local M = {Path=Path}

M.get_session_file = function(session_name)
  if not session_name or session_name == "" then
    error("A session name must be given !")
  end
  return Path:new(config.cwd, session_name):expand():gsub("\\", "/")
end

M.confirmed = function(prompt)
  print(strfmt("%s (type y, o or <space> to validate)", prompt))
  local answer = vim.fn.nr2char(vim.fn.getchar()):lower()
  return answer == "y" or answer == "o" or answer == " "
end

M.confirmed_overwrite = function(filename)
  return config.force_overwrite or M.confirmed(strfmt("Overwrite '%s' ?", filename))
end

M.confirmed_delete = function(filename)
  return config.force_delete or M.confirmed(strfmt("Delete '%s' ?", filename))
end


M.file_ok_for = function(operation, file, filename)
  local file_exists = Path:new(file):is_file()
  if operation == "add" or operation == "save" then
    return not file_exists or M.confirmed_overwrite(filename)
  elseif operation == "delete" then
    return not file_exists or M.confirmed_delete(filename)
  elseif operation == "restore" then
    return file_exists
  end
  error(strfmt("Unknown operation '%s' !", operation))
end

M.log = function(message, ...)
  if config.verbose then
    print(strfmt(message, ...))
  end
end

return M
