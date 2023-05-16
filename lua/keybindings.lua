vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opt = {
  noremap = true, silent = true,
  -- 在 expr 映射中，nvim_replace_termcodes() 会被自动应用于 Lua 函数返回的字符串
  -- expr = true
}

-- 文件树
map('n', '<leader>t', ':NvimTreeToggle<CR>', opt)
map("n", "<C-S-t>", ":NvimTreeToggle<CR>", opt)
-- 打开/关闭 tab
map("n", "<C-n>", ":tabnew<CR>", opt)
map("n", "<C-S-w>", ":bd<CR>", opt)
map("n", "<C-c>", ":bd<CR>", opt)

-- 自动保存
map("i", "<esc>", "<esc>:w<CR>", opt)

-- tab 切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("i", "<C-h>", "<esc>:w<CR>:BufferLineCyclePrev<CR>", opt)
map("i", "<C-l>", "<esc>:w<CR>:BufferLineCycleNext<CR>", opt)

-- 注释
map("n", "<leader>c", ":CommentToggle<CR>", opt)
map("n", "<C-\\>", ":CommentToggle<CR>", opt)
map("v", "<C-\\>", ":'<,'>CommentToggle<CR>", opt)
map("i", "<C-\\>", "<esc>:CommentToggle<CR>:w<CR>", opt)

map("i", "<C-BS>", "<C-W>", opt)

-- Git blame
map("n", "<C-g>", ":GitBlame<cr>", opt)
-- 保存文件
map("n", "<C-s>", ":w<cr>", opt)
map("i", "<C-s>", "<esc>:w<cr>", opt)

-- 文件搜索 / 光标所在词搜索 / 全文搜索
local builtin = require('telescope.builtin')
map("n", "<C-a>", ':Telescope live_grep default_text=<C-R>=expand(\"<cword>\")<cr><cr>', opt)
map("n", "<C-p>", ':Telescope find_files find_command=rg,--files,--hidden,-g!.git <cr>', opt)

-- 另外三种光标所在词搜索绑定方式
function _G.rg_live_grep_cword()
  -- vim.call 等价于 vim.fn
  -- builtin.live_grep{default_text=vim.call('expand','<cword>') }
  builtin.live_grep{default_text=vim.fn.expand('<cword>')}
end
-- vim.keymap.set('n', '<C-a>', rg_live_grep_cword, {})
-- vim.keymap.set('n', '<C-a>', ':lua rg_live_grep_cword() <cr>', {})
-- vim.keymap.set('n', '<C-a>', ":call v:lua.rg_live_grep_cword()<cr>", {})

-- 指定目录 :Telescope live_grep search_dirs={"app/","lib/"}
map('n', '<C-S-f>', ':Telescope live_grep search_dirs={}<cr>', opt)
vim.keymap.set('n', '<leader>f', ':Telescope live_grep <cr>', {})

-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local pluginKeys = {}
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true ,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- end of super Tab
  }
end

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here

  map('n', "<D-1>", ':NvimTreeToggle<CR>', opt)
  map('i', "<D-1>", '<esc>:NvimTreeToggle<CR>', opt)
  map('n', "<D-s>", ":w<cr>", opt)
  map('i', "<D-s>", '<esc>:w<CR>', opt)
  map('n', "<D-q>", ":qa<cr>", opt)
  map('n', "<D-w>", ":bd<cr>", opt)
  map('n', "<D-t>", ":tabnew<cr>", opt)
  map('n', "<D-d>", "dd", opt)
  map('n', "<D-[>", ":BufferLineCyclePrev<cr>", opt)
  map('n', "<D-]>", ":BufferLineCycleNext<cr>", opt)
  map('i', "<D-[>", "<esc>:BufferLineCyclePrev<cr>", opt)
  map('i', "<D-]>", "<esc>:BufferLineCycleNext<cr>", opt)
end

if vim.fn.has('gui_vimr') == 1 then
  -- Here goes some VimR specific settings like
  map('n', "<D-1>", ':NvimTreeToggle<CR>', opt)
  map('i', "<D-1>", '<esc>:NvimTreeToggle<CR>', opt)
  map('n', "<D-s>", ":w<cr>", opt)
  map('i', "<D-s>", '<esc>:w<CR>', opt)
  map('n', "<D-q>", ":qa<cr>", opt)
  map('n', "<D-w>", ":bd<cr>", opt)
  map('n', "<D-t>", ":tabnew<cr>", opt)
  map('n', "<D-d>", "dd", opt)
  map('n', "<S-D-{>", ":BufferLineCyclePrev<cr>", opt)
  map('n', "<S-D-}>", ":BufferLineCycleNext<cr>", opt)
  map('i', "<S-D-{>", "<esc>:BufferLineCyclePrev<cr>", opt)
  map('i', "<S-D-}>", "<esc>:BufferLineCycleNext<cr>", opt)
  map('n', '<S-D-f>', ':Telescope live_grep<cr>', {})
  map('i', "<D-BS>", "<C-W>", opt)
  map('i', "<D-/>", "<esc>:CommentToggle<CR>", opt)
  map('n', "<D-/>", ":CommentToggle<CR>", opt)
  map('v', "<D-/>", ":'<,'>CommentToggle<CR>", opt)
end

return pluginKeys
