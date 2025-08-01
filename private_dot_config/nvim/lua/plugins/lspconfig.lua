return {
{
  "neovim/nvim-lspconfig",
   lazy = false,
   config = function()
   vim.lsp.config('apex_ls', {
	cmd = {
	    '/usr/bin/java',
	    '-cp',
	    '/Users/przemyslaw.kadej-external/.config/apex-jorje-lsp.jar',
	    'apex.jorje.lsp.ApexLanguageServerLauncher',
	    '-Ddebug.internal.errors=true',
            '-Ddebug.semantic.errors=false',
            '-Ddebug.completion.statistics=false',
            '-Xmx512m',
            '-Dlwc.typegeneration.disabled=true',
	},
      filetypes = { 'cls', 'trigger', 'apex' },
      root_dir = vim.fn.getcwd(),
      --root_dir = '/Users/przemyslaw.kadej-external/projects/oCRM',
        apex_jar_path = '/Users/przemyslaw.kadej-external/.config/apex-jorje-lsp.jar',
	apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
	apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage    
    });
    local servers = { "html", "apex_ls" }
    vim.lsp.enable(servers)
    
    -- Użyj 'gd' do skoku do definicji
    vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

   end,
},
}
