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

local servers = {
  "bashls",     -- bash/sh/zsh
  "lua_ls",
  "pyright",    -- python
  "tsserver",   -- javascript (and typescript)
  "html",
  "cssls",
  "jsonls",
  "dockerls",
  "yamlls",
  "helm_ls",
  "marksman",   -- markdown
  "vimls",      -- vim + vimdoc
}

if vim.lsp.config and vim.lsp.enable then
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
  vim.lsp.enable(servers)
else
  -- Neovim < 0.10 fallback
  local lspconfig = require("lspconfig")

  local function setup(name, opts)
    if lspconfig[name] then
      lspconfig[name].setup(opts or { capabilities = capabilities })
    end
  end

  for _, name in ipairs(servers) do
    setup(name, { capabilities = capabilities })
  end

  setup("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = { diagnostics = { globals = { "vim" } } },
    },
  })

  setup("bashls", {
    capabilities = capabilities,
    filetypes = { "sh", "bash", "zsh" },
  })
end
