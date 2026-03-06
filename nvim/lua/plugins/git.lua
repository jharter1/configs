-- Git integration plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next git hunk" })
				vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous git hunk" })

				-- Actions
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
			end,
		},
	},
}
