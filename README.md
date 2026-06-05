# quickterm.nvim

A minimal per-tab terminal toggle for Neovim.

No setup. No dependencies. Just two keymaps and a small Lua file.

---

## Features

- Toggle terminal in a bottom split per tab
- Create new terminal instances
- Each tab has its own terminal state
- Lightweight (single-file plugin)
- Uses only Neovim built-in API

---

## Default keymaps

 - <kbd>Ctrl</kbd>+<kbd>`</kbd> — Toggle terminal
 - <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd> — Open new terminal

Works in both Normal and Terminal mode.

---

## Behavior

### Toggle (<kbd>Ctrl</kbd>+<kbd>`</kbd>)

- Opens a bottom split terminal if closed
- Hides it if already visible
- Reuses the same terminal buffer per tab

### New terminal (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd>)

- Always creates a fresh terminal buffer
- Opens in a new bottom split
- Does not reuse previous terminal

---

## Installation

### vim.pack

```lua
vim.pack.add({
  "https://github.com/sakhnik/quickterm.nvim",
})
```

### lazy.nvim

```lua
{
  "sakhnik/quickterm.nvim",
}
