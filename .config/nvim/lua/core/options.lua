local opt = vim.opt

-- --------------------------------------------------------------------------
-- General
-- --------------------------------------------------------------------------

-- Use the system clipboard for all yank/delete/paste operations
-- This lets you copy from Neovim and paste into Chrome/Slack/etc.
opt.clipboard = "unnamed"

-- Show line numbers on the left side
opt.number = true

-- Define your leader key (the "shortcut prefix")
-- In Lua, 'vim.g' is used for global variables
vim.g.mapleader = "\\"

-- Link your shell aliases so Neovim can use them in terminal commands (:!)
vim.env.BASH_ENV = vim.fn.expand("~/.config/shell/aliases")

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Prevents mis-detection in mixed Markdown/TeX documents
vim.g.tex_flavor = "latex"

-- --------------------------------------------------------------------------
-- TABS & INDENTATION
-- --------------------------------------------------------------------------

-- Visual width of a tab character
opt.tabstop = 4

-- Number of spaces that a <Tab> counts for while editing
opt.softtabstop = 4

-- Size of an "indent" (used for >> and << commands)
opt.shiftwidth = 4

-- Enable "smart" indentation logic based on the code syntax
-- opt.smartindent = true

-- Don't turn tabs into spaces by default (use actual tab characters)
opt.expandtab = false

-- Copy the indentation from the previous line when starting a new one
opt.autoindent = true

-- --------------------------------------------------------------------------
-- FILE SEARCHING & NAVIGATION
-- --------------------------------------------------------------------------

-- Allow the :find command to look recursively into all subfolders
opt.path:append("**")

-- Ignore case when completing file names in the command line
opt.wildignorecase = true

-- Exclude these patterns from file searches and autocompletion
opt.wildignore:append({ "*.pyc", "*_build_/*", "*/coverage/*", "*venv*/*" })

-- Wildmenu behavior: List matches, complete to longest common string, then cycle
-- opt.wildmode = "list:longest:full,full"

-- ---------------------------------------------------------------------------
-- VISUAL GUIDES & COLORS
-- ---------------------------------------------------------------------------

-- Scrolling
opt.scrolloff = 8

-- Draw a vertical bar at column 80 to help keep lines from getting too long.
opt.colorcolumn = "80"

-- Set the color of that column.
-- 'vim.api.nvim_set_hl' is the modern way to define colors.
-- 'ctermbg' is for basic terminals; 'bg' (background) is for modern GUIs/terminals.
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "darkgray", bg = "#444444" })

-- DIFF MODE LOGIC
-- If Neovim is started in 'diff' mode (e.g., nvim -d file1 file2), use a specific theme.
if vim.opt.diff:get() then
    vim.cmd("colorscheme evening")
end

-- ---------------------------------------------------------------------------
-- BACK-UPS
-- ---------------------------------------------------------------------------
-- stdpath('state') resolves to:
-- Linux: ~/.local/state/nvim
local state_dir = vim.fn.stdpath('state')

local dirs = {
  backup = state_dir .. '/backups',
  swap   = state_dir .. '/swaps',
  undo   = state_dir .. '/undo',
}

-- Ensure directories exist
for _, dir in pairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Apply settings
opt.backup = true
opt.backupdir = dirs.backup
opt.directory = dirs.swap
opt.undofile = true
opt.undodir = dirs.undo

-- Neovim's 'shada' (Shared Data) is the modern 'viminfo'
-- It already saves to stdpath('state')/shada/main.shada by default.
-- If you want to explicitly move it to your custom 'dirs' folder:
opt.shada:append({ n = state_dir .. '/shada/main.shada' })
