-- ---------------------------------------------------------------------------
-- KEY MAPPINGS (Muscle Memory)
-- ---------------------------------------------------------------------------
local keymap = vim.keymap.set

-- ESCAPE REMAPS
-- 'qq' to exit Insert mode. Much faster than reaching for the Esc key.
keymap("i", "qq", "<Esc>", { desc = "Exit insert mode with qq" })

-- 'qq' to exit Visual mode.
keymap("v", "qq", "<Esc>", { desc = "Exit visual mode with qq" })

-- TAB NAVIGATION
-- Quick movements between tabs
keymap("n", "tn", ":tabn<CR>", { desc = "Next tab" })
keymap("n", "tp", ":tabp<CR>", { desc = "Previous tab" })
-- ':tabm' moves the current tab's position (requires a number input)
keymap("n", "tm", ":tabm ", { desc = "Move tab" })
-- ':tabnew' opens a new tab, optionally with a file name
keymap("n", "tt", ":tabnew ", { desc = "New tab" })
-- Split the current buffer into its own new tab
keymap("n", "ts", ":tab split<CR>", { desc = "Split current into tab" })

-- TAGS & WINDOWS
-- Open a tag definition in a new tab.
-- Logic: Open in split (<C-w><C-]>), then move split to new tab (<C-w>T).
keymap("n", "<Leader><C-]>", "<C-w><C-]><C-w>T", { silent = true, desc = "Open tag in new tab" })

-- SYSTEM CLIPBOARD (Explicit)
-- Even though you have 'clipboard=unnamed', these are great for being explicit
-- using the '+' register (the system clipboard).
keymap({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard" })

-- CODE INDENTATION
-- In visual mode, stay in visual mode after indenting/out-indenting.
-- Usually, Vim drops you back to Normal mode after one '>', but 'gv' re-selects.
keymap("v", "<", "<gv", { desc = "Indent left and re-select" })
keymap("v", ">", ">gv", { desc = "Indent right and re-select" })

-- SEARCH
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- FILES
keymap("n", "<Leader>ex", vim.cmd.Ex)

-- EDITING
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap('n', '<Leader>w', ':w<CR>', { desc = 'Save file' })
