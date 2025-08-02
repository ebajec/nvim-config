local M = {}
M.setup = function()

local function smart_width()
  return math.floor(vim.o.columns * 0.5)
end

vim.diagnostic.config({
	virtual_text = true,
	float = {
		wrap = true,
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		max_width = smart_width(),
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { max_width = smart_width() }
)
end

return M
