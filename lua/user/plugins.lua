local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  -- Packer can manage itself
  use { "wbthomason/packer.nvim", commit = "dcd2f380bb49ec2dfe208f186236dd366434a4d5" }
  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "171aface9bb47b48fbe71ef98ac5574d04812501" }
  use { "lunarvim/darkplus.nvim", commit = "d308e9538f0e50cc3e80afc4ed904ab8b8e10fe6" }

  -- The completion plugin 
  use { "hrsh7th/nvim-cmp" }
  --  snippet engine
  use { "L3MON4D3/LuaSnip" }
  -- snippet completions
  use { "saadparwaiz1/cmp_luasnip" }
  -- buffer completions
  use { "hrsh7th/cmp-buffer" }
  -- path completions
  use { "hrsh7th/cmp-path" }
  -- nvim-cmp source for neovim's built-in language server client.
  use { "hrsh7th/cmp-nvim-lsp" }
  -- nvim-cmp source for neovim Lua API
  use { "hrsh7th/cmp-nvim-lua" }
  -- a bunch of snippets to use
  use { "rafamadriz/friendly-snippets" }

  -- LSP
  use { "neovim/nvim-lspconfig" }
  -- simple to use language server installer
  use { "williamboman/mason.nvim"}
  use { "williamboman/mason-lspconfig.nvim" }
  -- for formatters and linters
  use { "jose-elias-alvarez/null-ls.nvim" }
  -- automatically highlighting other uses of the word under the cursor using either LSP
  use { "RRethy/vim-illuminate" }

  -- Telescope 
  -- Dependencies: pacman -S ripgrep 
  use { "nvim-telescope/telescope.nvim" }

  -- Treesitteruse
  use {	"nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "p00f/nvim-ts-rainbow" }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
