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
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map('n',"<leader>hs", gs.stage_hunk, {desc = "Stage hunk"})
			map('n',"<leader>hr", gs.reset_hunk, {desc = "Reset hunk"})
			map('n', '<leader>ghB', gs.blame, {desc = "Blame"})
			map('n', ']c', function() gs.nav_hunk("next") end,{desc = "Next hunk"})
			map('n', '[c', function() gs.nav_hunk("prev") end,{desc = "Prev hunk"})
		end,
	})
	end,
}
