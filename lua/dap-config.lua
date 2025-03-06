local dap = require("dap")

vim.keymap.set("n", "<F5>",	 dap.continue)
vim.keymap.set("n", "<F10>",	 dap.step_over)
vim.keymap.set("n", "<F11>",	 dap.step_into)
vim.keymap.set("n", "<F12>",	 dap.step_out)
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
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
  command = 'codelldb',  -- Ensure this executable is in your PATH
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

-- Configuration for C++ debugging.
dap.configurations.cpp = {
  {
    name = "Launch executable",
    type = "cppdbg",
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
    setupCommands = {
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
}

dap.listeners.after.event_output["my_output_handler"] = function(session, body)
  if body.category == "stdout" or body.category == "stderr" then
    vim.schedule(function()
      vim.api.nvim_out_write(body.output)
    end)
  end
end

-- Use the same configuration for C files.
dap.configurations.c = dap.configurations.cpp

