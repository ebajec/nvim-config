return
{
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},

	config = function() require("tokyonight").setup({
		style = "moon",
		on_highlights = function(hl, c)
			-- change TSFunction (definitions & calls)
			hl.TSFunction = { fg = "#FF0000", bg = c.none }
			-- change TSMethod (method calls)
			hl.TSMethod   = { fg = "#FF0000" }
			-- if you have @function.call capture enabled:
			hl.TSFunctionCall       = { fg = "#FF0000" }
			hl.TSFunctionMethodCall = { fg = "#FF0000" }
	  	end,
	})
	end,
}
