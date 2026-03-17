return {
  -- Patch markdownlint to not run on CLAUDE.md via condition on the linter itself
  {
    "mfussenegger/nvim-lint",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function(ev)
          if ev.data ~= "nvim-lint" then return end
          local lint = require("lint")
          if lint.linters["markdownlint-cli2"] then
            lint.linters["markdownlint-cli2"].condition = function(ctx)
              return not ctx.filename:match("CLAUDE%.md$")
            end
          end
        end,
      })
    end,
  },

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
              or vim.fs.dirname(fname)
          end,
        },
      },
    },
  },

}
