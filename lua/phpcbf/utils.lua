local config = require("phpcbf.config")

local utils = {}

-- Get the setting for phpcbf path
function utils.get_phpcbf_path()
	if config.user_opts.phpcbf_path then
		return config.user_opts.phpcbf_path
	end
	print("no phpcbf path set")
end

-- Get the setting for phpcbf ruleset
function utils.get_phpcbf_ruleset()
	if config.user_opts.phpcbf_ruleset then
		return config.user_opts.phpcbf_ruleset
	end
	print("no phpcbf ruleset")
end

-- Get the setting for auto_format
function utils.get_auto_format()
	if config.user_opts.auto_format then
		return config.user_opts.auto_format
	end
	print("no phpcbf ruleset")
end

return utils
