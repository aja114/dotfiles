return {
  "Pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    execution_message = {
      message = function() -- Do not print any message
        return ""
      end,
    },
    enabled = true,
    trigger_events = { "InsertLeave", "TextChanged" },
    debounce_delay = 2000, -- saves at most once per second
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      -- only save normal, modifiable buffers (skip terminals, help, etc.)
      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        return true
      end
      return false
    end,
  },
}
