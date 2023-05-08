-- 1. luaeval: vimscript 调用 lua
-- 2. v:lua 这个全局 Vim 变量允许您直接从 Vimscript 调用全局 Lua 函数（_G）
-- lua << EOF
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end
-- EOF

-- inoremap <silent> <expr> <Tab>
--     \ pumvisible() ? '\<C-n>' :
--     \ v:lua.check_back_space() ? '\<Tab>' :
--     \ completion#trigger_completion()
-- 3. lua 调用 vimscript: vim.api.nvim_eval()
-- 4. vim.api.nvim_exec() 或者 vim.cmd() 此函数用于计算 Vimscript 代码块。
-- vim.cmd('buffers')
-- vim.cmd([[
-- let g:multiline_list = [
--             \ 1,
--             \ 2,
--             \ 3,
--             \ ]

-- echo g:multiline_list
-- ]])
-- 5. vim.api.nvim_command('%s/foo/bar/g')

-- 6. Neovim 提供了一组 API 函数来设置选项或获取其当前值：
-- vim.o: 行为类似于 :let &{option-name}
-- vim.go: 行为类似于 :let &g:{option-name}
-- vim.bo: 适用于 buffer-local 选项，行为类似于 :let &l:{option-name}
-- vim.wo: 适用于 window-local 选项，行为类似于 :let &l:{option-name}
-- 全局选项：
-- vim.api.nvim_set_option()
-- vim.api.nvim_get_option()
-- 几种等价方式
-- vim.api.nvim_set_option('smarttab', false)
-- print(vim.api.nvim_get_option('smarttab')) -- false
-- vim.o.smarttab = false -- let &smarttab = v:false
-- print(vim.o.smarttab) -- false
-- vim.opt.smarttab = false
-- print(vim.opt.smarttab:get()) -- false
-- 缓冲区选项：
-- vim.api.nvim_buf_set_option()
-- vim.api.nvim_buf_get_option()
-- 窗口选项：
-- vim.api.nvim_win_set_option()
-- vim.api.nvim_win_get_option()
-- 几种等价方式
-- vim.api.nvim_win_set_option(0, 'number', true)
-- vim.api.nvim_buf_set_option(10, 'shiftwidth', 4)
-- print(vim.api.nvim_win_get_option(0, 'number')) -- true
-- print(vim.api.nvim_buf_get_option(10, 'shiftwidth')) -- 4
-- vim.bo.shiftwidth = 4 -- 如果未给出编号，则使用当前缓冲区 / 窗口
-- print(vim.bo.shiftwidth) -- 4
-- vim.bo[4].expandtab = true -- same as vim.api.nvim_buf_set_option(4, 'expandtab', true)
-- vim.wo.number = true -- same as vim.api.nvim_win_set_option(0, 'number', true)

-- 7. 调用 Vimscript 函数: vim.fn.{function}()
-- print(vim.fn.printf('Hello from %s', 'Lua'))
-- local reversed_list = vim.fn.reverse({ 'a', 'b', 'c' })
-- print(vim.inspect(reversed_list)) -- { "c", "b", "a" }
-- local function print_stdout(chan_id, data, name)
--     print(data[1])
-- end
-- vim.fn.jobstart('ls', { on_stdout = print_stdout })

-- vim.fn 的功能与 vim.call 完全相同.
-- 和 vim.api.nvim_call_function 的不同之处在于，vim.fn 中数据类型的转换是自动的：
-- 对于浮点数类型，vim.api.nvim_call_function 会返回一个 table 并且它不支持 Lua 闭包作为参数；vim.fn 可以直接处理这些类型。

-- 8. Neovim 提供了一系列的 api 函数来设置获取和删除映射
-- 全局映射：
-- vim.api.nvim_set_keymap()
-- vim.api.nvim_get_keymap()
-- vim.api.nvim_del_keymap()
-- 缓冲区映射：
-- vim.api.nvim_buf_set_keymap()
-- vim.api.nvim_buf_get_keymap()
-- vim.api.nvim_buf_del_keymap()
-- Neovim 提供了两个函数来设置 / 删除映射：
-- vim.keymap.set()
-- vim.keymap.del()

-- 9. 定义用户命令
-- 全局用户命令
-- vim.api.nvim_create_user_command()
-- vim.api.nvim_del_user_command()
-- Buffer-local 的用户命令
-- vim.api.nvim_buf_create_user_command()
-- vim.api.nvim_buf_del_user_command()
-- 例如：
-- vim.api.nvim_create_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })
-- :command! -nargs=1 Upper echo toupper(<q-args>)
-- vim.cmd('Upper hello world') -- prints "HELLO WORLD"
-- 或者使用 lua 函数
-- vim.api.nvim_create_user_command(
--     'Upper',
--     function(opts)
--         print(string.upper(opts.args))
--     end,
--     { nargs = 1 }
-- )

-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jk移动时光标下上方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
-- vim.wo.colorcolumn = "100"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = true
-- 使用增强状态栏后不再需要 vim 的模式提示
vim.o.showmode = false
-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.o.wrap = false
vim.wo.wrap = false
-- 行结尾可以跳到下一行
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
-- 允许隐藏被修改过的buffer
-- vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 等待mappings
vim.o.timeoutlen = 100
vim.o.timeout = false
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
-- vim.o.listchars = "space:·"
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.pumheight = 10
-- always show tabline
vim.o.showtabline = 2

vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99

-- 设置剪贴板
vim.o.clipboard = 'unnamed'

if vim.g.neovide then
  vim.o.guifont = "Menlo:h14" 
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_remember_window_position = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
end

function _G.get_vars(name)
  local v = vim.api.nvim_get_var(name)
  return v
end

-- 主题
vim.cmd.colorscheme 'hardhacker'
