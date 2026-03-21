-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- A modular Neovim configuration with LSP, completion, and modern plugins
--
-- Structure:
--   lua/core/       - Core Neovim settings (options, keymaps, autocmds)
--   lua/config/     - Configuration utilities (lazy.nvim bootstrap)
--   lua/plugins/    - Plugin specifications organized by category
-- ============================================================================

-- Load core configuration
require("core.options")   -- Vim options and settings
require("core.keymaps")   -- General keymaps
require("core.autocmds")  -- Auto-commands (auto-save, etc.)

-- Bootstrap and configure lazy.nvim
require("config.lazy")

-- Load all plugins
require("lazy").setup({
	{ import = "plugins" },
}, {
	rocks = { enabled = false },
})

-- Set colorscheme
vim.cmd([[colorscheme dracula]])


