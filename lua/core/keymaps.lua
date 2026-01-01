-- General keymaps
local keymap = vim.keymap.set

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Visual mode improvements
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })
keymap("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Smart tab behavior (Codeium, snippets, completion)
keymap("i", "<Tab>", function()
	-- Try Codeium first
	local ok, res = pcall(vim.fn["codeium#Accept"])
	if ok and res ~= "" then
		return res
	end
	-- Try snippet jump
	if vim.fn["vsnip#jumpable"](1) == 1 then
		return "<Plug>(vsnip-jump-next)"
	end
	-- Try completion
	local cmp_ok, cmp = pcall(require, "cmp")
	if cmp_ok and cmp.visible() then
		cmp.select_next_item()
		return ""
	end
	return "<Tab>"
end, { expr = true, silent = true, desc = "Smart tab" })

keymap("i", "<S-Tab>", function()
	-- Try snippet jump back
	if vim.fn["vsnip#jumpable"](-1) == 1 then
		return "<Plug>(vsnip-jump-prev)"
	end
	-- Try completion previous
	local cmp_ok, cmp = pcall(require, "cmp")
	if cmp_ok and cmp.visible() then
		cmp.select_prev_item()
		return ""
	end
	return "<S-Tab>"
end, { expr = true, silent = true, desc = "Smart shift-tab" })
