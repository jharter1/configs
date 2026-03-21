-- LSP configuration
return {
	-- Mason for managing LSP servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSP bridge
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",        -- Lua
					"terraformls",   -- Terraform
					"yamlls",        -- YAML
					"ts_ls",         -- TypeScript/JavaScript
					"pyright",       -- Python
					"gopls",         -- Go
					"rust_analyzer", -- Rust
					"jsonls",        -- JSON
					"html",          -- HTML
					"cssls",         -- CSS
					"bashls",        -- Bash
					"dockerls",      -- Dockerfile
					"ruby_lsp",      -- Ruby
				},
			})
		end,
	},

	-- Lazydev for Neovim Lua development
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/nvim-cmp" },
		config = function()
			-- Global LSP configuration
			vim.lsp.config("*", {
				root_markers = { ".git", "init.lua", "package.json", "pyproject.toml", "go.mod" },
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- YAML LSP
			vim.lsp.config("yamlls", {
				single_file_support = true,
			})

			-- Docker LSP
			vim.lsp.config("dockerls", {
				single_file_support = true,
				filetypes = { "dockerfile" },
			})

			-- Terraform LSP
			vim.lsp.config("terraformls", {
				single_file_support = true,
				filetypes = { "terraform", "tf", "hcl" },
			})

			-- Python LSP
			vim.lsp.config("pyright", {
				single_file_support = true,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})

			-- Go LSP
			vim.lsp.config("gopls", {
				single_file_support = true,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})

			-- Bash LSP
			vim.lsp.config("bashls", {
				single_file_support = true,
				filetypes = { "sh", "bash" },
			})

			-- Ruby LSP
			vim.lsp.config("ruby_lsp", {
				single_file_support = true,
				filetypes = { "ruby" },
				init_options = {
					enabledFeatures = {
						"diagnostics",
						"formatting",
						"codeActions",
					},
					formatter = "rubocop",
				},
			})

			-- Lua LSP
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
							enable = true,
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Enable all LSP servers
			local servers = {
				"lua_ls",
				"terraformls",
				"yamlls",
				"ts_ls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"jsonls",
				"html",
				"cssls",
				"bashls",
				"dockerls",
				"ruby_lsp",
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- LSP keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

			-- Diagnostic navigation
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
		end,
	},
}
