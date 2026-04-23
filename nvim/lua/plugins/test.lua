-- Test runner plugins
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"olimorris/neotest-rspec",
		},
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
			{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
			{ "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						args = { "-v" },
						runner = "pytest",
						-- Use virtual env python when available
						python = function()
							local venv = vim.fn.getcwd() .. "/.venv/bin/python"
							if vim.fn.executable(venv) == 1 then
								return venv
							end
							return vim.fn.exepath("python3")
						end,
					}),
					require("neotest-go")({
						experimental = { test_table = true }, -- table-driven test display
						args = { "-count=1", "-timeout=60s", "-v" },
					}),
					require("neotest-rspec")({
						rspec_cmd = function()
							-- Prefer bundle exec when Gemfile exists
							if vim.fn.filereadable("Gemfile") == 1 then
								return vim.tbl_flatten({ "bundle", "exec", "rspec" })
							end
							return { "rspec" }
						end,
					}),
				},
				output = { open_on_run = true },
				summary = { open = "botright vsplit | vertical resize 50" },
				discovery = { enabled = true },
			})
		end,
	},
}
