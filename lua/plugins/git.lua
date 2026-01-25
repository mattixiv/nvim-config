return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      vim.api.nvim_set_hl(0, "GitsignsCurrentLineBlame", { link = "Comment" })
    end,
  },
}
