return {
  -- GitHub Copilot core

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        yaml = true,
        ["*"] = true,
      },
    },
  },

  -- CopilotChat for chatting inside Neovim
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    cmd = { "CopilotChat", "CopilotChatOpen" },
    opts = {
      window = {
        layout = "float", -- or "vertical"
      },
    },
  },
}
