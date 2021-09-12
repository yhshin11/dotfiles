-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Source simple settings and mappings from vimrc
vim.api.nvim_command('source ~/.vimrc')

-- General vim settings
vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- Temporary fix for folding files opened with telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.cmd("command! UserRefreshFold lua vim.opt.foldmethod = \"expr\"")
vim.cmd("command! UserPrint lua print(\"message\")")

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

--------------------------------
-- Telescope settings
--------------------------------
lvim.builtin.telescope.on_config_done = function()
  local actions = require "telescope.actions"
  -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
  -- for input mode
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
  -- for normal mode
  lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
  -- Esc to quit in insert mode
  -- lvim.builtin.telescope.defaults.mappings.i["<Esc>"] = actions.close
end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["<Tab>"] = { ":e #<cr>", "Switch to alternate buffer" }
lvim.builtin.which_key.mappings["<Space>"] = { ":Telescope commands<CR>", "Command palette" }
-- Buffer menu
lvim.builtin.which_key.mappings["bb"] = { ":Telescope buffers<CR>", "Switch to buffer" }
lvim.builtin.which_key.mappings["bd"] = { ":bd<cr>", "Kill buffer" }
-- File menu
lvim.builtin.which_key.mappings["ff"] = { ":lua require('telescope.builtin').find_files({previewer=false})<CR>", "Find files" }
lvim.builtin.which_key.mappings["fa"] = { ":lua require('telescope.builtin').find_files({previewer=false, hidden=true, no_ignore=true})<CR>", "Find files -a" }
lvim.builtin.which_key.mappings["fr"] = { ":Telescope oldfiles<CR>", "Recent files" }
lvim.builtin.which_key.mappings["fe"] = { ":lua require('telescope.builtin').file_browser({layout_config={preview_width=0.6}})<CR>", "File browser" }
lvim.builtin.which_key.mappings["fs"] = { ":w<cr>", "Save file" }
-- Search menu
lvim.builtin.which_key.mappings["sg"] = { ":Telescope live_grep<CR>", "Live grep" }
lvim.builtin.which_key.mappings["sh"] = { ":Telescope help_tags<CR>", "Help tags" }
-- Project menu
lvim.builtin.which_key.mappings["P"] = { ":lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "lua", "python", }
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  --------------------------------
  -- Color schemes
  {"folke/tokyonight.nvim"},
  {"NTBBloodbath/doom-one.nvim"},
  {"ChristianChiarulli/nvcode-color-schemes.vim"},
  {"sainnhe/sonokai"},
  --
  --------------------------------

  --------------------------------
  -- Essential plugins
  {
    "tpope/vim-surround",
    keys = {"c", "d", "y"}
  },
  { "tpope/vim-repeat" },
  --
  --------------------------------

  --------------------------------
  -- Learning plugins
  {
    -- Next-generation motion plugin
    -- Overrides s/S/f/F/t/T in normal and visual mode
    -- Overrides x/X in visual mode
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    -- Extended incrementing/decrementing
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      local dial = require "dial"
      vim.cmd [[
      nmap <C-a> <Plug>(dial-increment)
      nmap <C-x> <Plug>(dial-decrement)
      vmap <C-a> <Plug>(dial-increment)
      vmap <C-x> <Plug>(dial-decrement)
      vmap g<C-a> <Plug>(dial-increment-additional)
      vmap g<C-x> <Plug>(dial-decrement-additional)
      ]]

      dial.augends["custom#boolean"] = dial.common.enum_cyclic {
        name = "boolean",
        strlist = { "true", "false" },
      }
      table.insert(dial.config.searchlist.normal, "custom#boolean")

      -- For Languages which prefer True/False, e.g. python.
      dial.augends["custom#Boolean"] = dial.common.enum_cyclic {
        name = "Boolean",
        strlist = { "True", "False" },
      }
      table.insert(dial.config.searchlist.normal, "custom#Boolean")
    end,
  },
  --
  --------------------------------

  --------------------------------
  -- Luxury plugins
  {
    -- lsp signature hint when you type
    "ray-x/lsp_signature.nvim",
    config = function() require"lsp_signature".on_attach() end,
    event = "InsertEnter"
  },
  {
    -- Telescope extension for projects
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  --
  --------------------------------
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- Temporary fix for folding files opened with telescope
  -- https://github.com/nvim-telescope/telescope.nvim/issues/699
  { "FileReadPost", "*", "lua vim.opt.foldmethod = \"expr\"" },
  { "VimEnter", "*", "lua vim.opt.foldmethod = \"expr\"" },
}
