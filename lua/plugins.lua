return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	--Themes
	use { "ellisonleao/gruvbox.nvim" }
	use 'navarasu/onedark.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'folke/tokyonight.nvim'

  --Prettier
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
	use 'famiu/bufdelete.nvim'
	
	use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  --LSP
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use { "williamboman/mason.nvim" }
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("onsails/lspkind-nvim")
  use 'windwp/nvim-ts-autotag'
  use("nvim-treesitter/nvim-treesitter")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/nvim-cmp")
  use 'glepnir/lspsaga.nvim'
	use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })
  use {
	"windwp/nvim-autopairs"}
  use({
	"Pocco81/auto-save.nvim",
	config = function()
		 require("auto-save").setup {}
	end,
})
end)
