
-- lsp 
require("lspconfig").cmake.setup {}
require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
require("lspconfig").clangd.setup {
	cmd = {
		"clangd",
		"--background-index",
		"--header-insertion=never",
		"--completion-style=detailed"
	},
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(client,bufnr)
		local opts = {noremap = true, silent = false}
		local buf_set_keymap = vim.api.nvim_buf_set_keymap

		buf_set_keymap(bufnr, "n", "gd","<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		buf_set_keymap(bufnr, "n", "<leader>Rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

		buf_set_keymap(bufnr, "n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	end,
	flags = {
		debounce_text_changes = 100,
	},
}

require('lspconfig').glsl_analyzer.setup{}

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.comp"},
  callback = function()
    vim.bo.filetype = "glsl"
  end,
})


