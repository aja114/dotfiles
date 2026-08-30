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
