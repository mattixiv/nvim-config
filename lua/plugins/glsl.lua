return {
  -- Treesitter grammar for GLSL
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "glsl" } },
  },

  -- GLSL language server via Mason
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        glsl_analyzer = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "glsl-analyzer" } },
  },
}
