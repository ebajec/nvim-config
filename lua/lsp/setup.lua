local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	
	-- Configure clangd for C/C++
	lspconfig.clangd.setup({
		cmd = { "clangd", "--background-index" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
		on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true }
			local bufmap = vim.api.nvim_buf_set_keymap
			bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			bufmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		-- Add more key mappings as needed...
		end,
		flags = {
		  debounce_text_changes = 150,
		},
	})
end

return M
