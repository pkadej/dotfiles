return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("nvim-tree").setup {}
    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
          require'nvim-tree'.open()
        end
      end
    })
    end,
}
