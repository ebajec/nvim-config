return{
	  "ellisonleao/glow.nvim",
	  cmd = "Glow",         -- lazy-load the plugin when :Glow is executed
	  ft = { "markdown" },  -- or load it automatically when editing Markdown files
	  config = function()
		require("glow").setup({
		  -- Optional settings:
		  style = "dark",  -- override the default style if needed ("dark" or "light")
		  width = 120,     -- set the width of the preview window
		  -- You can add other configuration options here.
		})
	  end,
	}
