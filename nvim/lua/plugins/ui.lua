-- UI and visual plugins
return {
	-- Color scheme
	{ "dracula/vim", name = "dracula" },

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "dracula",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
			})
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					separator_style = "slant",
					always_show_bufferline = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					color_icons = true,
				},
			})
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPre",
		config = function()
			require("ibl").setup()
		end,
	},

	-- Notifications and UI improvements
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			words = { enabled = true },
			gitbrowse = { enabled = true },
			input = { enabled = false },
			indent = { enabled = false },
		},
	},

	-- Enhanced UI for vim.ui.select and vim.ui.input
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- Keybinding help
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "modern",
				delay = 500,
				icons = {
					breadcrumb = "»",
					separator = "➜",
					group = "+",
				},
				win = {
					border = "rounded",
					padding = { 1, 2 },
				},
			})
			-- Register keybinding groups
			wk.add({
				{ "<leader>f", group = "Find" },
				{ "<leader>ff", desc = "Find files" },
				{ "<leader>lg", desc = "Live grep" },
				{ "<leader>fb", desc = "Find buffers" },
				{ "<leader>x", group = "Diagnostics" },
				{ "<leader>xx", desc = "Toggle diagnostics" },
				{ "<leader>xd", desc = "Buffer diagnostics" },
				{ "<leader>g", group = "Git" },
				{ "<leader>gg", desc = "LazyGit" },
				{ "<leader>gf", desc = "LazyGit file history" },
				{ "<leader>h", group = "Git Hunk" },
				{ "<leader>hp", desc = "Preview hunk" },
				{ "<leader>c", group = "Code" },
				{ "<leader>ca", desc = "Code actions" },
				{ "<leader>rn", desc = "Rename symbol" },
				{ "<leader>e", desc = "Toggle file tree" },
				{ "<leader>o", desc = "Open oil file browser" },
				{ "<leader>a", desc = "Toggle symbol outline" },
				{ "<leader>t", group = "Test" },
				{ "<leader>tt", desc = "Run nearest test" },
				{ "<leader>tf", desc = "Run file tests" },
				{ "<leader>ts", desc = "Toggle test summary" },
				{ "<leader>to", desc = "Toggle test output" },
			})
		end,
	},

	-- LSP progress indicator
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = { notification = { window = { winblend = 0 } } },
	},
}
