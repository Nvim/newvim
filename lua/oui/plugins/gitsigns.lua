return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })

				map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })

				map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle blame" })
				map("n", "<leader>gd", gs.diffthis, { desc = "Diff history" })
				-- map("n", "<leader>td", gs.toggle_deleted)

				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line" })

				-- map("n", "<leader>hD", function()
				-- 	gs.diffthis("~")
				-- end)

				-- map("v", "<leader>hs", function()
				--   gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				-- end)
				-- map("v", "<leader>hr", function()
				--   gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				-- end)

				-- Text object
				-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
