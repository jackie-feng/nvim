
" 基础设置
lua require('basic')
" Packer插件管理
lua require('plugins')
" 快捷键映射
lua require('keybindings')
" 自动命令
lua require('autocmds')

" 插件配置
"  lua require('plugin-config/which-key')
"  lua require('plugin-config/nvim-autopairs')
lua require('plugin-config/nvim-cursorword')
lua require('plugin-config/nvim-tree')
lua require('plugin-config/gitsigns')
lua require('plugin-config/bufferline')
lua require('plugin-config/telescope')

" lsp
lua require('lsp/setup')
lua require('lsp/nvim-cmp')
"  lua require('lsp/diagnostic_signs')
"  lua require('lsp/language_servers')
