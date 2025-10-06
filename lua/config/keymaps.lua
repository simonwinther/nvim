-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---------- Copilot keymaps ----------
-- Smart <Tab>: Copilot if visible, else completion, else insert tab
vim.keymap.set("i", "<Tab>", function()
  local ok, s = pcall(require, "copilot.suggestion")
  if ok and s.is_visible() then
    s.accept()
    return ""
  end
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  return "\t"
end, { expr = true, silent = true })

-- Smart <S-Tab>: previous completion item, else backspace a tab stop
vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<BS>"
end, { expr = true, silent = true })

---------- Telescope keymaps ----------
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", tb.find_files, { desc = "Telescope Files" })
vim.keymap.set("n", "<leader>tg", tb.live_grep, { desc = "Telescope Grep" })
vim.keymap.set("n", "<leader>tb", tb.buffers, { desc = "Telescope Buffers" })
vim.keymap.set("n", "<leader>th", tb.help_tags, { desc = "Telescope Help" })
