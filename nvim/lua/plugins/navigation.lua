-- Navigation and file management plugins
return {
	-- Dependency for telescope and others
	{ "nvim-lua/plenary.nvim" },

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 30,
					side = "left",
				},
				filters = {
					dotfiles = false,
				},
			})
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle file tree" })

			-- Auto-open nvim-tree when nvim starts with no file
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 0 then
						require("nvim-tree.api").tree.open()
					end
				end,
			})
		end,
	},

	-- Symbol outline sidebar
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle symbol outline" },
		},
		opts = {
			layout = { min_width = 28 },
			show_guides = true,
			attach_mode = "global",
		},
	},

	-- Buffer-based file management
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				view_options = {
					show_hidden = true,
				},
			})
			vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open oil file browser" })
		end,
	},
}
