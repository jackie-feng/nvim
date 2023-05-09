-- local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
--   clear = true,
-- })

-- local autocmd = vim.api.nvim_create_autocmd

-- -- nvim-tree 自动关闭
-- autocmd("BufEnter", {
--   nested = true,
--   group = myAutoGroup,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--       vim.cmd("quit")
--     end
--   end,
-- })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'sh', 'make', 'python' },
  callback = function()
    vim.api.nvim_command('set noexpandtab')
  end
})
