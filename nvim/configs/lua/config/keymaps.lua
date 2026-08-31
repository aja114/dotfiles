-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Delete/change without yanking (black hole register): the unnamed register
-- only receives yanks, so `p` always pastes the last yanked text.
-- To actually cut (move) text, use the clipboard register: "+d{motion}
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("x", "d", '"_d')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("x", "c", '"_c')

-- Save-all: :w writes every modified buffer (like :wall), so format-on-save
-- runs everywhere. Only expands when the cmdline is exactly "w", so
-- :w <file>, :wq, visual :'<,'>w etc. are unaffected.
vim.cmd([[cnoreabbrev <expr> w (getcmdtype() == ':' && getcmdline() ==# 'w') ? 'wall' : 'w']])

-- Override LazyVim's <C-s> ("Save File") to save all buffers.
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>wall<cr><esc>", { desc = "Save All Files" })
