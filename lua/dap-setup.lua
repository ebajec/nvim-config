local dap = require("dap")

vim.keymap.set("n", "<F5>",	 dap.continue)
vim.keymap.set("n", "<F10>",	 dap.step_over)
vim.keymap.set("n", "<F11>",	 dap.step_into)
vim.keymap.set("n", "<F12>",	 dap.step_out)
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader>dt', dap.terminate)
vim.keymap.set("n", "<Leader>B", function()
  	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>e', function()
	require('dapui').eval()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>du', function()
	require('dapui').toggle()
end)

-- Python configuration example:
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python"  -- or customize to your virtualenv
    end,
  },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'OpenDebugAD7',  -- Ensure this executable is in your PATH
  options = {
    detached = false,
  },
}

local function get_debug_args(input)
  local args = {}
  for arg in string.gmatch(input, "([^,]+)") do
    table.insert(args, vim.trim(arg))
  end
  return args
end

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- Change the command to point to your codelldb adapter binary:
    command = extension_path .. "adapter/codelldb", -- or just "codelldb" if it's in your PATH
    args = { "--port", "${port}" },
  },
}

-- Configuration for C++ debugging.
dap.configurations.cpp = {
  {
    name = "Launch executable",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Prompts for the path to the executable to debug
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
    	return get_debug_args(vim.fn.input("Debug arguments (comma separated):"))
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
	disableDataFormatting = true,
    setupCommands = {
      {
        --description = "Enable pretty-printing for gdb",
        --text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
}

-- Use the same configuration for C files.
dap.configurations.c = dap.configurations.cpp

-- mason-nvim-dap

require("mason-nvim-dap").setup({
	ensure_installed = {
		"cppdbg"
	},
	automatic_installation = true,
})

--dapui

require("dapui").setup({
	layouts = {
	{
		elements = { "scopes", "breakpoints", "stacks", "watches" },
	      	size = 40,
	      	position = "left",
	},
	{
	      elements = { "repl" },
	      size = 0.25, -- 25% of total lines
	      position = "bottom",
	},
	},
})
require("nvim-dap-virtual-text").setup({
	enabled = true
})




