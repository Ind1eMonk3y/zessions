local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local get_dropdown = require("telescope.themes").get_dropdown

local zessions = require("zessions")
local zconfig = require("zessions.config")


local M = {actions={}, config={}}

M.actions.add = function(prompt_bufnr)
  local line = action_state.get_current_line()
  if line == "" then return end
  actions.close(prompt_bufnr)
  zessions.save_session(line)
end

M.actions.save = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then return end
  actions.close(prompt_bufnr)
  zessions.save_session(entry.value)
end

M.actions.delete = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then return end
  actions.close(prompt_bufnr)
  zessions.delete_session(entry.value)
end

M.actions.restore = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then return end
  actions.close(prompt_bufnr)
  zessions.restore_session(entry.value)
end

M.actions.complete = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then return end
  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.value)
end


M.sessions = function(opts, plugin_opts)
  local opts = opts or {}

  -- Sync with extension config
  M.update_config(opts)

  -- Sync with plugin config
  zconfig:update(plugin_opts)
  zconfig:update({cwd=M.config.cwd})

  local default_opts = {
    cwd = M.config.cwd or zconfig.cwd,
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<C-s>", M.actions.save)
      map("i", "<C-a>", M.actions.add)
      map("i", "<C-d>", M.actions.delete)
      map("i", "<C-e>", M.actions.complete)
      actions.select_default:replace(M.actions.restore)
      return true
    end
  }
  local dropdown_opts = get_dropdown({
      prompt_title = "Sessions",
      previewer = false,
      layout_config = {
        width = 30,
      },
  }, opts)

  opts = vim.tbl_deep_extend("force", default_opts, dropdown_opts, M.config)
  require("telescope.builtin").find_files(opts)
end

M.update_config = function(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  return M.config
end

M.setup = function(opts)
  return M.update_config(opts)
end

return require("telescope").register_extension {
  setup = M.setup,
  exports = {sessions = M.sessions, setup = M.setup}
}
