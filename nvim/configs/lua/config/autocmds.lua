-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Join format-on-save changes into the previous undo block, so a single `u`
-- undoes your edit and its formatting together. This file is loaded before
-- LazyVim creates its "LazyFormat" BufWritePre autocmd, and BufWritePre
-- autocmds run in creation order, so this undojoin always executes first.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("user_format_undojoin", { clear = true }),
  callback = function()
    -- fails (silently) right after an undo; the format then gets its own block
    pcall(vim.cmd, "silent! undojoin")
  end,
})
