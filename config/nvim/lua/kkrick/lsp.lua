vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- Register completions with LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Optional tweaks (examples)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } },
  },
})

-- bashls doesn't always include zsh by default; force it if you want:
vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

-- Enable servers (must match lspconfig server names)
vim.lsp.enable({
  "bashls",     -- bash/sh/zsh
  "lua_ls",
  "pyright",    -- python
  "ts_ls",      -- javascript (and typescript)
  "html",
  "cssls",
  "jsonls",
  "dockerls",
  "yamlls",
  "helm_ls",
  "marksman",   -- markdown
  "vimls",      -- vim + vimdoc
})

