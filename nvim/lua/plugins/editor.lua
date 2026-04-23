-- Editor enhancement plugins
return {
	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local status, ts = pcall(require, "nvim-treesitter.configs")
			if not status then
				return
			end

			ts.setup({
				ensure_installed = {
					"lua",
					"vim",
					"terraform",
					"bash",
					"javascript",
					"typescript",
					"tsx",
					"python",
					"go",
					"rust",
					"json",
					"html",
					"css",
					"markdown",
					"yaml",
					"ruby",
				},
				highlight = { enable = true },
			})
		end,
	},

	-- Sticky context header showing current function/class while scrolling
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPre",
		opts = {
			max_lines = 4,
			min_window_height = 20,
			multiline_threshold = 1,
		},
	},

	-- Surround: add/change/delete surrounding pairs (ys, cs, ds)
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Auto-pairs for brackets and quotes
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Commenting
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},

	-- TODO comments highlighting
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Code formatting
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				yaml = { "yamlfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				python = { "black" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				bash = { "shfmt" },
				ruby = { "rubocop" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- Markdown render (in-buffer)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {},
	},

	-- Diagnostics panel
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
		},
		opts = {
			use_diagnostic_signs = true,
		},
	},
}
