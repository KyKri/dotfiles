require('nvim-treesitter.config').setup({
	ensure_installed = { "bash", "zsh", "lua", "python", "javascript", "html", "css", "csv", "json", "dockerfile", "helm", "markdown", "markdown_inline", "yaml", "vim", "vimdoc" },
	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

