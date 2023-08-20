local config = require("phpcbf.config")
local command = require("phpcbf.command")
local phpcbf = {}
local user_opts = {}

phpcbf.setup = function(opts)
	opts = opts or {}
	user_opts.auto_format = opts.auto_format or false
	user_opts.phpcbf_path = opts.phpcbf_path or nil
	user_opts.phpcbf_ruleset = opts.phpcbf_ruleset or nil
	config.set_user_opts(user_opts)

	-- Create the PHPCBF command
	command.create_command()
end

return phpcbf
