return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Prevent Marksman from starting on CLAUDE.md — it crashes on it
        marksman = {
          root_dir = function(bufnr)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname:match("CLAUDE%.md$") then return nil end
            local util = require("lspconfig.util")
            return util.root_pattern(".marksman.toml")(fname)
              or util.root_pattern(".git")(fname)
              or util.path.dirname(fname)
          end,
        },
      },
    },
  },

  -- Don't lint CLAUDE.md — it's not meant for humans and markdownlint is overkill
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          condition = function(ctx)
            return not ctx.filename:match("CLAUDE%.md$")
          end,
        },
      },
    },
  },
}
