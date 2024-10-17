-- lspconfig
local nvim_lsp = require('lspconfig')
local fzf_lsp = require('fzf_lsp')
local servers = { clangd = {}, pylsp = {}, tsserver = {}, cmake = {}, lua_ls = {}, tblgen_lsp_server = {}}

-- language specific lsp configs
--
-- pylsp config
servers['pylsp'] = {
  pylsp = {
    plugins = {
      pylint = {
        enabled = true
      },
      pycodestyle = {
        enabled = false
      }
    }
  }
}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>References<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>cgq', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

for lsp, settings in pairs(servers) do
	nvim_lsp[lsp].setup {
    settings = settings,
		on_attach = on_attach
	}
end

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {'tablegen'},
--   callback = function()
--     local compile_commands_arg = '--tablegen-compilation-database='..util.find_git_ancestor(vim.fn.expand('%:p'))..'/tablegen_compile_commands.yml'
--     vim.lsp.start({
--         name = "tblgen_lsp_server",
--         cmd = {"tblgen-lsp-server", compile_commands_arg},
--         root_dir = vim.fs.dirname(vim.fs.find({'tablegen_compile_commands.yml', '.git'}, { upward = true })[1]),
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {'python', 'cpp'},
--   callback = function()
--     vim.lsp.start({
--         name = "ffi-navigator",
--         cmd = {"python", "-m", "ffi_navigator.langserver"},
--         root_dir = vim.fs.dirname(vim.fs.find({'.git', 'pyproject.toml'}, { upward = true })[1]),
--     })
--   end,
-- })

-- Don't like virtual text for diagnostics
vim.diagnostic.config({ virtual_text = false })

-- vim.keymap.set('i', '<tab>', function()
--   if vim.fn.pumvisible() == 1 then return '<c-n>' end
--   return '<tab>'
-- end, { expr = true })

-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources(
  -- {
  --   { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  -- },
  {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['clangd'].setup {
--   capabilities = capabilities
-- }
