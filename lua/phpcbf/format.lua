local utils = require("phpcbf.utils")
local config = require("phpcbf.config")

local format = {}

function string:endswith(suffix)
	return tostring(self):sub(-#suffix) == suffix
end

-- Format the current file with phpcbf
function format.format_phpcbf()
	local phpcbf_path = utils.get_phpcbf_path()
	local file_path = vim.fn.expand("%:p")

	if config.user_opts.check_file_extension and file_path:endswith(".php") == false then
		return
	end

	-- If we have phpcbf path
	if phpcbf_path then
		-- Show message
		print("formatting file ...")
		local command = { phpcbf_path }
		-- Add ruleset if set
		if config.user_opts.phpcbf_ruleset then
			table.insert(command, "--standard=" .. config.user_opts.phpcbf_ruleset)
		end
		-- Add file path
		table.insert(command, file_path)
		-- Run the formatter
		format.run(command)
		return
	end
	-- No phpcbf
	print("phpcbf executable not found")
end

-- Wrapper for format_phpcbf() that checks if auto_format is enabled first
function format.auto_format_phpcbf()
	if not config.user_opts.auto_format then
		print("auto_format is disabled")
		return
	end
	format.format_phpcbf()
end

-- chdir to current file dir (so phpcbf can find the ruleset),
-- then format and reload the file,
-- then set cwd back to its starting value.
function format.run(command)
	local cwd = vim.fn.getcwd()
	vim.cmd("set autochdir")
	vim.system(command):wait()
	vim.cmd("e")
	vim.cmd("set autochdir!")
	vim.cmd(table.concat({ "cd", cwd }, " "))
end

return format
