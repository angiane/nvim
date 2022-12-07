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
  use { "hrsh7th/nvim-cmp", commit = "93f385c17611039f3cc35e1399f1c0a8cf82f1fb" }
  --  snippet engine
  use { "L3MON4D3/LuaSnip", commit = "5ce70a08442e97ac55ce14e71dd7d151ea5f4d8e" }
  -- snippet completions
  use { "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" }
  -- buffer completions
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }
  -- path completions
  use { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }
  -- nvim-cmp source for neovim's built-in language server client.
  use { "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" }
  -- nvim-cmp source for neovim Lua API
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }
  -- a bunch of snippets to use
  use { "rafamadriz/friendly-snippets", commit = "9b3e497cf0c3abcf73d791968a9768a22405fa13" }

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "8faa599646f482d3ed04e645eb04af94bcd12feb" }
  -- simple to use language server installer
  -- Dependencies: sudo pacman -S nodejs npm
  use { "williamboman/mason.nvim", commit = "2381f507189e3e10a43c3932a3ec6c2847180abc" }
  use { "williamboman/mason-lspconfig.nvim", commit = "4674ed145fd0e72c9bfdb32b647f968b221bf2f2" }
  -- for formatters and linters
  use { "jose-elias-alvarez/null-ls.nvim", commit = "b3d2ebdb75cf1fa4290822b43dc31f61bd0023f8" }
  -- automatically highlighting other uses of the word under the cursor using either LSP
  use { "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" }

  -- Telescope 
  -- Dependencies: pacman -S ripgrep 
  use { "nvim-telescope/telescope.nvim", commit = "cabf991b1d3996fa6f3232327fc649bbdf676496" }

  -- Treesitteruse
  use {	"nvim-treesitter/nvim-treesitter", commit = "440401c506ec9b87cd3824ad17631115ab860cc5", run = ":TSUpdate" }
  use { "p00f/nvim-ts-rainbow", commit = "064fd6c0a15fae7f876c2c6dd4524ca3fad96750" }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs", commit = "9fa996123031b4cad100bd5afad04384a622c8a7" }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "d076301a634198e0ae3efee3b298fc63c055a871" }

  -- Nvim-tree Dependencies: nvim-web-devicons for file icons
  use { "nvim-tree/nvim-web-devicons", commit = "189ad3790d57c548896a78522fd8b0d0fc11be31" }
  use { "nvim-tree/nvim-tree.lua", commit = "f8489c992998e1e1b45aec65bdb9615e5cd59a61" }

  -- Buffer line
  use { "akinsho/bufferline.nvim", commit = "4ecfa81e470a589e74adcde3d5bb1727dd407363" }

  -- Markdown Preview
  -- sudo npm install --global yarn
  -- cd plugin file markdown-preview .local/share/nvim/site/pack/packer/start/markdown-preview.nvim/app then yarn install
  use { "iamcco/markdown-preview.nvim", commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96" }

  -- Lualine a statusline
  use { "nvim-lualine/lualine.nvim", commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165" }

  -- Indent blankline adds indentation guides 
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }

  -- Comment
  use { "numToStr/Comment.nvim", commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
