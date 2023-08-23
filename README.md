# PHPCBF.nvim

This neovim plugin provides a minimal config and some commands for configuring and running the [PHP Code Beautifier and Fixer (PHPCBF)](https://phpqa.io/projects/phpcbf.html) script against the current buffer.

I mostly built this for my own use, it may grow to include [phpcs](https://github.com/squizlabs/PHP_CodeSniffer)

## Installation
---

### Packer

```
-- PHPCBF
use("ahollister/phpcbf.nvim")
```

## Setup
---

You will need to call the setup function for the plugin to work:

```
require("phpcbf").setup({
	auto_format = true,
	phpcbf_path = "/Users/yourname/.composer/vendor/bin/phpcbf",
	phpcbf_ruleset = "PSR2",
    check_file_extension = true,
})
```

### Setup options

#### auto_format

*Defaults to false.*

Contrary to the name this does not actually format code on save on it's own. It simply sets a variable that defines whether the command `PHPCBF auto_format_phpcbf` should format the code or be blocked from doing so.

If you want to automatically run the formatter on file save, you can create an ftplugin in `after/ftplugin/php.lua` like so:

```
-- Runs after each file save on BufWritePost event.
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	callback = function()
		-- Format the current file.
		vim.cmd([[silent PHPCBF auto_format_phpcbf]])
	end,
})
```

With the above in place, the phpcbf script will run after file save, only if `auto_format` is set to true.

#### phpcbf_path

*Defaults to nil.*

Specifies a path for the phpcbf executable that will be used when the `PHPCBF format_phpcbf()` command is run.

#### phpcbf_ruleset

*Defaults to nil.*

Specifies a ruleset to be passed into the `--standard` argument of the phpcbf command. This can be set to nil or left out of the setup options if you want phpcbf to be run without a `--standard` argument.

#### check_file_extension

*Defaults to false.*

If you need to have this plugin explicitly check that the file name of the current buffer ends in .php before formatting, set this option to true.

I'm not sure why this happens, but for some reason the file type plugin [described above](https://github.com/ahollister/phpcbf.nvim#auto_format) seems to occasionally think that non PHP buffers, like the one [oil.nvim](https://github.com/stevearc/oil.nvim) uses for file system manipulations, are PHP? That's what this setting is for.

## Commands
---

`:PHPCBF format_phpcbf` - Runs the formatter against the current buffer.

`:PHPCBF get_phpcbf_path` - Prints the currently set `phpcbf_path`

`:PHPCBF get_phpcbf_ruleset` - Prints the currently set `phpcbf_ruleset`

`:PHPCBF enable_auto_format` - Sets the `auto_format` option to true.

`:PHPCBF disable_auto_format` - Sets the `auto_format` option to false.

`:PHPCBF toggle_auto_format` - Toggles the `auto_format` option.
