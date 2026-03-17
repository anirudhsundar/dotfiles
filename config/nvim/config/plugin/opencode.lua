if vim.fn.executable("opencode") ~= 1 then
  vim.notify("opencode.nvim: `opencode` binary not found, skipping setup", vim.log.levels.WARN)
  return
end

local tmux_state = { pane_id = nil, last_pane_id = nil }
local opencode_port = tonumber(vim.env.OPENCODE_PORT) or (35000 + (vim.fn.getpid() % 20000))
local opencode_cmd = "opencode --port " .. opencode_port

local function in_tmux()
  return vim.env.TMUX and vim.env.TMUX ~= ""
end

local function pane_exists(pane_id)
  pane_id = pane_id or tmux_state.pane_id
  if not pane_id then
    return false
  end

  local result = vim.system({ "tmux", "list-panes", "-F", "#{pane_id}" }, { text = true }):wait()
  if result.code ~= 0 then
    return false
  end

  for line in (result.stdout or ""):gmatch("[^\r\n]+") do
    if line == pane_id then
      return true
    end
  end

  return false
end

local function current_pane_id()
  local result = vim.system({ "tmux", "display-message", "-p", "#{pane_id}" }, { text = true }):wait()
  if result.code ~= 0 then
    return nil
  end
  return vim.trim(result.stdout or "")
end

local function start_tmux_split()
  if not in_tmux() then
    vim.notify("opencode.nvim: not inside tmux", vim.log.levels.ERROR)
    return
  end

  if pane_exists() then
    return
  end

  local result = vim.system({
    "tmux",
    "split-window",
    "-h",
    "-d",
    "-c",
    vim.fn.getcwd(),
    "-P",
    "-F",
    "#{pane_id}",
    opencode_cmd,
  }, { text = true }):wait()

  if result.code == 0 then
    tmux_state.pane_id = vim.trim(result.stdout or "")
  else
    vim.notify("opencode.nvim: failed to start tmux split", vim.log.levels.ERROR)
  end
end

local function stop_tmux_split()
  if pane_exists() then
    vim.system({ "tmux", "kill-pane", "-t", tmux_state.pane_id }):wait()
  end

  tmux_state.pane_id = nil
end

vim.g.opencode_opts = {
  server = {
    port = opencode_port,
    start = start_tmux_split,
    stop = stop_tmux_split,
    toggle = function()
      if not pane_exists() then
        start_tmux_split()
        return
      end

      local current = current_pane_id()
      if current == tmux_state.pane_id then
        if pane_exists(tmux_state.last_pane_id) then
          vim.system({ "tmux", "select-pane", "-t", tmux_state.last_pane_id }):wait()
        else
          vim.system({ "tmux", "last-pane" }):wait()
        end
      else
        tmux_state.last_pane_id = current
        vim.system({ "tmux", "select-pane", "-t", tmux_state.pane_id }):wait()
      end
    end,
  },
}

-- Optional: auto-reload on edits
vim.o.autoread = true

-- Example keymaps
-- vim.keymap.set({'n','x'}, '<C-a>', function()
--   require('opencode').ask("@this: ", { submit = true })
-- end, { desc = "Ask opencode…" })

vim.keymap.set({'n','x'}, '<leader>oc', function()
  require('opencode').select()
end, { desc = "Execute opencode action…" })

vim.keymap.set('n', '<leader>ot', function()
  require('opencode').toggle()
end, { desc = "Toggle opencode" })
