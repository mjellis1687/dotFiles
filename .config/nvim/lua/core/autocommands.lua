local augroup = vim.api.nvim_create_augroup("MyCustomSettings", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- --------------------------------------------------------------------------
-- FILETYPE SPECIFIC RULES
-- --------------------------------------------------------------------------

-- This closes the "preview" window (<c-w>z) and then closes all
-- Location Lists (lcl) and QuickFix windows (ccl) in all windows.
autocmd("FileType", {
    pattern = "python",
    group = augroup,
    callback = function()
        vim.opt_local.expandtab = true
        vim.keymap.set("n", "<Leader>c", "<C-w>z :windo lcl|ccl<CR>", { buffer = true })
    end,
})

-- Highlight trailing whitespace as red
vim.api.nvim_set_hl(0, "BadWhitespace", { ctermbg = "red", bg = "red" })

-- Apply the red highlight to spaces at the end of lines in Python and C files
autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.py", "*.pyw", "*.c", "*.h" },
    group = augroup,
    command = "match BadWhitespace /\\s\\+$/",
})

-- "The Terminator": Automatically strip all trailing whitespace on save
-- This ensures you never accidentally commit "invisible" extra spaces.
autocmd("BufWritePre", {
    pattern = "*",
    group = augroup,
    command = [[%s/\s\+$//e]],
})

-- Markdown Specific Autocmds
autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local opts = { buffer = true, remap = false }

    -- Column snippet
    vim.keymap.set('n', '<Leader>c', 'i::: {.columns}<CR>:::: {.column width=<++>%}<CR><CR><++><CR><CR>::::<CR>:::: {.column width=<++>%}<CR><CR><++><CR><CR>::::<CR>:::<Esc>11k2h', opts)

    -- Live View PDF
    vim.keymap.set('n', '<Leader>lv', ':!xdg-open %:r.pdf &<CR><CR>', opts)

    -- Save and MakeThe complex column snippet
    -- Equivalent to: autocmd FileType markdown noremap <Leader>w :w<CR>:make<CR>
    -- Note: This overrides the global <Leader>w only when in a Markdown file
    vim.keymap.set('n', '<Leader>w', ':w<CR>:make<CR>', opts)
  end,
})

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tex", "*.md" },
    group = augroup,
    callback = function()
		vim.opt_local.spell = true
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.scrolloff = 0
    end,
})
