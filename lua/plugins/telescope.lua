-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    -- use maintained branch; your lockfile may still pin an older commit
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = function(_, opts)
      opts = opts or {}
      opts.defaults = opts.defaults or {}

      -- --- Patch Telescope's Treesitter highlighter for Neovim 0.11+ ---
      -- Some older Telescope utils call `vim.treesitter.language.ft_to_lang`.
      -- On 0.11+ only `get_lang` exists. We patch a safe shim AND override the
      -- previewer's ts_highlighter to use the new API directly.
      local ok_ts, ts = pcall(require, "vim.treesitter")
      if ok_ts and ts and ts.language then
        local lang = ts.language
        if not lang.ft_to_lang and type(lang.get_lang) == "function" then
          -- Backward-compat alias so any old call doesn't explode
          lang.ft_to_lang = lang.get_lang
        end
      end

      -- Override Telescope's highlighter to use new API with guards
      local ok_utils, tsutils = pcall(require, "telescope.previewers.utils")
      if ok_utils then
        tsutils.ts_highlighter = function(bufnr, path)
          -- get filetype, then map to treesitter language
          local ft = vim.filetype.match({ filename = path }) or vim.bo[bufnr].filetype
          local lang = ft
          if vim.treesitter and vim.treesitter.language and vim.treesitter.language.get_lang then
            lang = vim.treesitter.language.get_lang(ft) or ft
          end
          -- start treesitter highlighting; ignore failures quietly
          pcall(vim.treesitter.start, bufnr, lang)
        end
      end
      -- --------------------------------------------------------------------

      -- Nice, stable layout defaults
      opts.defaults.layout_strategy = opts.defaults.layout_strategy or "horizontal"
      opts.defaults.sorting_strategy = opts.defaults.sorting_strategy or "ascending"
      opts.defaults.layout_config = opts.defaults.layout_config or { prompt_position = "top" }

      -- Optional: avoid weird previews on huge files but keep previewer on
      local previewers = require("telescope.previewers")
      local builtin_maker = previewers.buffer_previewer_maker
      opts.defaults.buffer_previewer_maker = function(filepath, bufnr, opts2)
        local st = vim.uv.fs_stat(vim.fn.expand(filepath))
        if st and st.size > 2 * 1024 * 1024 then
          return -- skip preview for files > 2MB
        end
        builtin_maker(filepath, bufnr, opts2)
      end

      return opts
    end,
  },
}
