return {
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

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Don't attach Marksman to CLAUDE.md — it tends to crash on it
        marksman = {
          on_attach = function(client, bufnr)
            if vim.api.nvim_buf_get_name(bufnr):match("CLAUDE%.md$") then
              vim.lsp.buf_detach_client(bufnr, client.id)
            end
          end,
        },
      },
    },
  },
}
