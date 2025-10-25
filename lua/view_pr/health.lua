local health = vim.health or require("health") -- Compatibility with older versions

local function has_cmd(cmd)
	return vim.fn.executable(cmd) == 1
end

return {
	check = function()
		health.start("view_pr health check")

		-- Check for Git
		if has_cmd("git") then
			health.ok("git is available")
		else
			health.error("git is not installed or not in PATH")
		end

		-- Check for GitHub CLI
		if has_cmd("gh") then
			health.ok("GitHub CLI (gh) is available")
		else
			health.warn("GitHub CLI (gh) is not installed. PR lookup will not work.")
		end
	end,
}
