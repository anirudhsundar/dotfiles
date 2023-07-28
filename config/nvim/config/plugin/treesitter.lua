require'nvim-treesitter.configs'.setup {
 highlight = {
   enable = true,
 },
}

require'nvim-treesitter.configs'.setup {
 incremental_selection = {
   enable = true,
   keymaps = {
     init_selection = "<leader>tn",
     node_incremental = "<leader>tl",
     scope_incremental = "<leader>tsl",
     node_decremental = "<leader>th",
   },
 },
}

require'nvim-treesitter.configs'.setup {
 indent = {
   enable = false
 }
}

-- Set folding based on treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
if vim.o.filetype ~= "vim" then
  vim.o.foldlevelstart = 99
end

require'nvim-treesitter.configs'.setup {
 textobjects = {
   select = {
     enable = true,
     keymaps = {
       -- You can use the capture groups defined in textobjects.scm
       ["af"] = "@function.outer",
       ["if"] = "@function.inner",
       ["ac"] = "@class.outer",
       ["ic"] = "@class.inner",
       ["iF"] = "@conditional.inner",
       ["aF"] = "@conditional.outer",

       -- Or you can define your own textobjects like this
       -- ["iF"] = {
       --   python = "(function_definition) @function",
       --   cpp = "(function_definition) @function",
       --   c = "(function_definition) @function",
       --   java = "(method_declaration) @function",
       -- },
     },
   },
 },
}

require'nvim-treesitter.configs'.setup {
 textobjects = {
   swap = {
     enable = true,
     swap_next = {
       ["<leader>tl"] = "@parameter.inner",
     },
     swap_previous = {
       ["<leader>th"] = "@parameter.inner",
     },
   },
 },
}

require'nvim-treesitter.configs'.setup {
 textobjects = {
   move = {
     enable = true,
     set_jumps = true, -- whether to set jumps in the jumplist
     goto_next_start = {
       ["]f"] = "@function.outer",
       ["]]"] = "@class.outer",
     },
     goto_next_end = {
       ["]F"] = "@function.outer",
       ["]["] = "@class.outer",
     },
     goto_previous_start = {
       ["[f"] = "@function.outer",
       ["[["] = "@class.outer",
     },
     goto_previous_end = {
       ["[F"] = "@function.outer",
       ["[]"] = "@class.outer",
     },
     goto_next = {
       ["]d"] = "@conditional.outer",
     },
     goto_previous = {
       ["[d"] = "@conditional.outer",
     }
   },
 },
}
