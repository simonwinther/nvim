-- nvim transparency + scheme tweaks
return {
  -- LazyVim's default scheme (tokyonight)
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = { sidebars = "transparent", floats = "transparent" },
    },
  },

  -- hard overrides so most UIs are glassy regardless of scheme
  {
    "LazyVim/LazyVim",
    init = function()
      local aug = vim.api.nvim_create_augroup("MyTransparent", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = aug,
        callback = function()
          local set = vim.api.nvim_set_hl
          for _, g in ipairs({
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "SignColumn",
            "LineNr",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "TabLineFill",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "TelescopeNormal",
            "TelescopeBorder",
            "WhichKeyFloat",
            "NoiceCmdlinePopup",
            "NoiceCmdlinePopupBorder",
            "SnacksPicker",
            "SnacksPickerBorder",
          }) do
            set(0, g, { bg = "none" })
          end
        end,
      })
    end,
  },
}
