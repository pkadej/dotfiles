return {
{
    "VPavliashvili/json-nvim",
    ft = "json", -- only load for json filetype
    lazy = false,
    config = function()
        local wk = require("which-key")
        wk.add({
          { "<leader>j", group = "json-nvim" },
        })
        vim.keymap.set("n", "<leader>jf", '<cmd>JsonFormatFile<cr>', { desc = 'Json format file' })
        vim.keymap.set("n", "<leader>jm", '<cmd>JsonMinifyFile<cr>', { desc = 'Json minify file' })
    end,
  }
}
