require("nvim-treesitter.configs").setup({
	ensure_installed = {"c","cpp","glsl","lua","vim","vimdoc","query","markdown","markdown_inline"},
	auto_install = true,
	highlight = { enable = true},
	indent = {enable = true},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			node_decremental = "<bs>"
		},
	},
})


