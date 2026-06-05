local term_state = {}

local function get_state()
  local tab = vim.api.nvim_get_current_tabpage()
  term_state[tab] = term_state[tab] or {}
  return term_state[tab]
end

local function ensure_buf(state)
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end
  return state.buf
end

local function open_split_with_buf(buf)
  vim.cmd("botright split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("startinsert")
  return win
end

local function start_shell_once(buf)
  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.jobstart(vim.o.shell, { term = true })
  end
end

local function show_term(state, buf)
  state.win = open_split_with_buf(buf)
  start_shell_once(buf)
end

local function open_term()
  local state = get_state()
  local buf = ensure_buf(state)
  show_term(state, buf)
end

local function close_term()
  local state = get_state()

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
  end

  state.win = nil
end

local function toggle_term()
  local state = get_state()

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    close_term()
  else
    open_term()
  end
end

local function new_term()
  local state = get_state()

  local buf = vim.api.nvim_create_buf(false, true)
  state.buf = buf

  show_term(state, buf)
end

vim.keymap.set({ "n", "t" }, "<C-`>", toggle_term, { silent = true, desc = "Toggle terminal" })
vim.keymap.set({ "n", "t" }, "<C-S-`>", new_term, { silent = true, desc = "Open new terminal" })
