-- local util = require 'lspconfig.util'

-- local get_compile_commands_path = function()
--   return '--tablegen-compilation-database='..util.find_git_ancestor(vim.fn.expand('%:p'))..'/tablegen_compile_commands.yml'
-- end
-- -- local tablegen_compile_commands_path = '--tablegen-compilation-database='..util.find_git_ancestor(vim.fn.expand('%:p'))..'/tablegen_compile_commands.yml'
-- return {
--   default_config = {
--     -- cmd = { 'tblgen-lsp-server' },
--     cmd = { 'tblgen-lsp-server' , get_compile_commands_path()},
--     -- cmd = { 'tblgen-lsp-server' , '--tablegen-compilation-database=/local/mnt/workspace/anirudh/llvm/mlir/llvm-project/tablegen_compile_commands.yml'},
--     filetypes = { 'tablegen' },
--     root_dir = function(fname)
--       return util.root_pattern('tablegen_compile_commands.yml')(fname) or util.find_git_ancestor(fname)
--     end,
--   },
--   docs = {
--     description = [[
-- https://mlir.llvm.org/docs/Tools/MLIRLSP/#tablegen-lsp-language-server--tblgen-lsp-server

-- The Language Server for the LLVM TableGen language

-- `tblgen-lsp-server` can be installed at the llvm-project repository (https://github.com/llvm/llvm-project)
-- ]],
--   },
-- }
