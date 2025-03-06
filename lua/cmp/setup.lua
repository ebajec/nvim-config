-- Require the cmp and luasnip modules

local M = {}

function M.setup()
	-- Require the cmp and luasnip modules
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    -- Specify how to expand snippets
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),  -- Scroll docs up
    ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- Scroll docs down
    ['<C-Space>'] = cmp.mapping.complete(),     -- Trigger completion menu
    ['<C-e>'] = cmp.mapping.abort(),            -- Abort completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completion source
    { name = 'luasnip' },   -- Snippet completions
  }, {
    { name = 'buffer' },    -- Buffer completions
    { name = 'path' },      -- File system paths
  })
})

-- Setup cmdline completions if needed
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

return M
