local config = require("phpcbf.config")
local command = require("phpcbf.command")

local phpcbf = {}

phpcbf.setup = function(opts)
	opts = opts or {}

	config.set_user_opts({
		auto_format = opts.auto_format or false,
		phpcbf_path = opts.phpcbf_path or nil,
		phpcbf_ruleset = opts.phpcbf_ruleset or nil,
		check_file_extension = opts.check_file_extension or false,
	})

	-- Create the PHPCBF command
	command.create_command()
end

return phpcbf
