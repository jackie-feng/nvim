return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  -- 主题
  use { "ellisonleao/gruvbox.nvim" }
  use 'navarasu/onedark.nvim'

  -- 文件树
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- 顶部栏
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- 文件搜索 / 全文搜索
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- 注释
  use "terrortylor/nvim-comment"
  require('nvim_comment').setup()

  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
  use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
  use 'hrsh7th/cmp-path'     -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
  use 'hrsh7th/nvim-cmp'
  -- vsnip
  use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
  use 'hrsh7th/vim-vsnip'
  -- 补全常用语言段
  use 'rafamadriz/friendly-snippets'
  -- lspkind 补全提示图标
  use 'onsails/lspkind-nvim'

  -- 对齐线
  use "lukas-reineke/indent-blankline.nvim"
  require("indent_blankline").setup {
    -- space_char_blankline = ' ',
    -- for example, context is off by default, use this to turn it on
    -- show_current_context = true,
    -- show_current_context_start = true,
  }

  -- git 文件行改动状态
  use 'lewis6991/gitsigns.nvim'

  -- git blame
  use {
    'dinhhuy258/git.nvim'
  }
  require('git').setup()

  use 'xiyaowong/nvim-cursorword'

  use 'wakatime/vim-wakatime'
end)
