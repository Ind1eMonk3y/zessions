local strfmt = string.format

local config = require("zessions.config")
local utils = require("zessions.utils")


local session_do = function(operation, session_name)
  local session_file = utils.get_session_file(session_name)
  local ok = utils.file_ok_for(operation, session_file, session_name)
  if not ok then return end

  if operation == "add" or operation == "save" then
    vim.cmd("silent! mksession! "..session_file)
    utils.log("Saved session '%s'", session_name)
  elseif operation == "delete" then
    utils.Path:new(session_file):rm()
    utils.log("Deleted session '%s'", session_name)
  elseif operation == "restore" then
    if config.bdelete then vim.cmd("silent! %bdelete") end
    vim.cmd("silent! source "..session_file)
    utils.log("Restored session '%s'", session_name)
  end
end

local M = {config=config}

M.save_session = function(session_name)
  session_do("save", session_name)
end

M.delete_session = function(session_name)
  session_do("delete", session_name)
end

M.restore_session = function(session_name)
  session_do("restore", session_name)
end

return M
