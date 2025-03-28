return{
	  "lewis6991/gitsigns.nvim",
	  lazy = true,
	  event = { "BufReadPre", "BufNewFile" },
	  config = function()
		require("gitsigns").setup({
		  signs = {
			add          = { text = "│" },
			change       = { text = "│" },
			delete       = { text = "_" },
			topdelete    = { text = "‾" },
			changedelete = { text = "~" },
		  },
		  current_line_blame = false, -- set to true if you want inline blame info
		})
	  end,
	}
