vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- 文件树
map('n', '<leader>t', ':NvimTreeToggle<CR>', opt)
map("n", "<C-S-t>", ":NvimTreeToggle<CR>", opt)
-- 打开/关闭 tab
map("n", "<C-n>", ":tabnew<CR>", opt)
map("n", "<C-S-w>", ":bd<CR>", opt)

-- tab 切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- 注释
map("n", "<leader>c", ":CommentToggle<CR>", opt)
map("n", "<C-\\>", ":CommentToggle<CR>", opt)
map("v", "<C-\\>", ":'<,'>CommentToggle<CR>", opt)

map("i", "<C-BS>", "<esc>viws", opt)
map("n", "<C-BS>", "viws", opt)

-- Git blame
map("n", "<C-g>", ":GitBlame<cr>", opt)
-- 保存文件
map("n", "<C-s>", ":w<cr>", opt)
map("i", "<C-s>", "<esc>:w<cr>", opt)

-- 文件搜索 / 光标所在词搜索 / 全文搜索
local builtin = require('telescope.builtin')
map("n", "<C-a>", ':Telescope live_grep theme=dropdown default_text=<C-R>=expand(\"<cword>\")<cr>', opt)
map("n", "<C-p>", ':Telescope find_files theme=dropdown<cr>', opt)
-- vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-S-f>', builtin.live_grep, {})
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
return pluginKeys