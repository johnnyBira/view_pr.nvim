vim.api.nvim_create_user_command("ViewPR", function()
	require("view_pr").view_pr_for_line()
end, { desc = "Open GitHub PR associated with the current line" })
