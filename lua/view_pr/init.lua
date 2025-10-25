local M = {}

function M.view_pr_for_line()
	-- 1. Get current file and line
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")

	-- 2. Run git blame for that line
	local blame_cmd = string.format("git blame -L%s,+1 --porcelain %s", line, vim.fn.shellescape(file))
	local blame_output = vim.fn.systemlist(blame_cmd)
	if vim.v.shell_error ~= 0 or #blame_output == 0 then
		vim.notify("git blame failed or no output", vim.log.levels.ERROR)
		return
	end

	-- 3. Extract the commit hash from the first line
	local commit = blame_output[1]:match("^([0-9a-f]+) ")
	if not commit or commit == "0000000000000000000000000000000000000000" then
		vim.notify("Could not determine a valid commit for this line", vim.log.levels.ERROR)
		return
	end

	-- 4. Search for a PR containing this commit using GitHub CLI
	local pr_cmd = string.format("gh pr list --search %s --state merged --json number,url", commit)
	local pr_output = vim.fn.systemlist(pr_cmd)
	if vim.v.shell_error ~= 0 or #pr_output == 0 then
		vim.notify("Failed to query PRs or no PRs found", vim.log.levels.INFO)
		return
	end

	-- 5. Decode JSON result
	local ok, pr_data = pcall(vim.json.decode, table.concat(pr_output, "\n"))
	if not ok or type(pr_data) ~= "table" or not pr_data[1] or not pr_data[1].url then
		vim.notify("No PR found for commit " .. commit, vim.log.levels.INFO)
		return
	end

	local url = pr_data[1].url

	-- 6. Open the PR in browser (works on Linux/macOS)
	local opener = vim.fn.has("mac") == 1 and "open" or "xdg-open"
	vim.fn.jobstart({ opener, url }, { detach = true })
	vim.notify("Opening PR: " .. url, vim.log.levels.INFO)
end

return M
