return
{
	"hrsh7th/cmp-nvim-lsp",   -- LSP source
    "hrsh7th/cmp-buffer",     -- Buffer source
    "hrsh7th/cmp-path",       -- Path source
    "hrsh7th/cmp-cmdline",    -- Command line source
    "L3MON4D3/LuaSnip",       -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- LuaSnip source for cmp
	"hrsh7th/nvim-cmp",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig"
		},
	config = function()
	end,
}
