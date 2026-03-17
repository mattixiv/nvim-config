-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Don't lint CLAUDE.md — clear nvim-lint diagnostics on open and on subsequent saves
do
  local function clear_claude_md_lint(bufnr)
    local lint_ns = vim.api.nvim_get_namespaces()["markdownlint-cli2"]
    if not lint_ns then return end
    if #vim.diagnostic.get(bufnr, { namespace = lint_ns }) > 0 then
      vim.diagnostic.reset(lint_ns, bufnr)
    end
  end

  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function(ev)
      if vim.api.nvim_buf_get_name(ev.buf):match("CLAUDE%.md$") then
        clear_claude_md_lint(ev.buf)
      end
    end,
  })

  -- Also clear for buffers already open before VeryLazy fired
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr):match("CLAUDE%.md$") then
      clear_claude_md_lint(bufnr)
    end
  end
end
