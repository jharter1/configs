-- Flash yanked region so you can see what was copied
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
	end,
})

-- Auto-save functionality
local auto_save_timer = nil

-- Helper function to get current timestamp
local function get_timestamp()
	return os.date("%I:%M:%S %p")
end

-- Immediate save on buffer leave or focus lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if
			vim.bo.modified
			and vim.bo.buftype == ""
			and vim.bo.filetype ~= "NvimTree"
			and vim.bo.filetype ~= "gitcommit"
			and vim.bo.filetype ~= "checkhealth"
		then
			vim.cmd("silent! update")
			local filename = vim.fn.expand("%:t")
			local timestamp = get_timestamp()
			vim.notify(
				string.format("Auto-saved: %s [%s]", filename, timestamp),
				vim.log.levels.INFO,
				{ title = "Auto-save" }
			)
		end
	end,
})

-- Debounced save after typing (1 second delay)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	callback = function()
		if
			vim.bo.modified
			and vim.bo.buftype == ""
			and vim.bo.filetype ~= "NvimTree"
			and vim.bo.filetype ~= "gitcommit"
			and vim.bo.filetype ~= "checkhealth"
		then
			-- Debounce: cancel previous timer and start a new one
			if auto_save_timer then
				auto_save_timer:stop()
			end
			auto_save_timer = vim.defer_fn(function()
				if vim.bo.modified then
					vim.cmd("silent! update")
					local filename = vim.fn.expand("%:t")
					local timestamp = get_timestamp()
					vim.notify(
						string.format("Auto-saved: %s [%s]", filename, timestamp),
						vim.log.levels.INFO,
						{ title = "Auto-save" }
					)
				end
			end, 1000)
		end
	end,
})
