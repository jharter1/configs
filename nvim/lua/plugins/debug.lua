-- Debug adapter protocol plugins
return {
	-- Auto-install debug adapters via Mason (debugpy for Python, delve for Go)
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		opts = {
			ensure_installed = { "python", "delve" },
			handlers = {}, -- use default handlers per adapter
		},
	},

	-- Inline variable values while debugging
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		opts = { commented = true },
	},

	-- Core DAP + UI
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
		},
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dB", function()
				require("dap").set_breakpoint(vim.fn.input("Condition: "))
			end, desc = "Conditional breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue / start" },
			{ "<leader>ds", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
			{ "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				layouts = {
					{
						elements = {
							{ id = "scopes",      size = 0.40 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks",      size = 0.25 },
							{ id = "watches",     size = 0.20 },
						},
						size = 50,
						position = "left",
					},
					{
						elements = {
							{ id = "repl",    size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 12,
						position = "bottom",
					},
				},
			})

			-- Auto open/close UI with session lifecycle
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

			-- Python: use mason-managed debugpy
			local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(debugpy)
			require("dap-python").test_runner = "pytest"

			-- Go: use mason-managed delve
			require("dap-go").setup()
		end,
	},
}
