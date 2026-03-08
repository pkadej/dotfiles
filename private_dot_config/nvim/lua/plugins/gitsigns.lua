return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  config = function()
    require('gitsigns').setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        vim.keymap.set('n', '<leader>gb', function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == 'gitsigns-blame' then
              vim.api.nvim_win_close(win, true)
              return
            end
          end
          vim.cmd('Gitsigns blame')
        end, { noremap = true, silent = true, desc = 'Git blame toggle' })
        map('n', '<leader>gB', function() gs.blame_line({ full = true }) end, 'Git blame line')
        map('n', '<leader>gd', gs.diffthis, 'Git diff')
        map('n', ']h', gs.next_hunk, 'Next hunk')
        map('n', '[h', gs.prev_hunk, 'Prev hunk')
      end,
    })
  end,
}
