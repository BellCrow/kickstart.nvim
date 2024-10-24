-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- if vim was called with an argument specifying a directory, make that directory the CWD
-- taken from: https://www.reddit.com/r/neovim/comments/1du176f/how_to_align_cwd_with_opened_folder/
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    local from = vim.uv.cwd()
    local target
    local args = vim.fn.argv()

    for _, arg in ipairs(type(args) == 'table' and args or {}) do
      if vim.fn.isdirectory(arg) then
        target = vim.fn.fnamemodify(arg, ':p')
        print(string.format('Changing CWD from %s to %s', from, arg))

        if target ~= nil then
          vim.cmd(string.format(':cd %s', target))
          vim.notify(string.format('cd to %s', target))
        end
      end
    end
    return true
  end,
})
