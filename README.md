# PHPCBF.nvim

This neovim plugin provides a minimal config and some commands for configuring and running the [PHP Code Beautifier and Fixer (PHPCBF)](https://phpqa.io/projects/phpcbf.html) script against the current buffer.

I mostly built this for my own use, it may grow to include [phpcs](https://github.com/squizlabs/PHP_CodeSniffer) too and if it does I will probably archive this repo and create a new plugin under a more relevant name.

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
})
```

### Setup options

#### auto_format

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

Specifies a path for the phpcbf executable that will be used when the `PHPCBF format_phpcbf()` command is run.

#### phpcbf_ruleset

Specifies a ruleset to be passed into the `--standard` argument of the phpcbf command. This can be set to nil or left out of the setup options if you want phpcbf to be run without a `--standard` argument.

### Commands

`:PHPCBF format_phpcbf` - Runs the formatter against the current buffer.

`:PHPCBF get_phpcbf_path` - Prints the currently set `phpcbf_path`

`:PHPCBF get_phpcbf_ruleset` - Prints the currently set `phpcbf_ruleset`

`:PHPCBF enable_auto_format` - Sets the `auto_format` option to true.

`:PHPCBF disable_auto_format` - Sets the `auto_format` option to false.

`:PHPCBF toggle_auto_format` - Toggles the `auto_format` option.
