vim.g.mapleader = " "

vim.keymap.set("n", "<leader>id", "iAidas Jurelevičius PS 2 k., 3 gr., 1 pogr.<Esc>", { desc = "Auto inserts [I][D]" })
vim.keymap.set("n", "<leader>she", "i#!/bin/bash<ENTER><Esc>", { desc = "Auto inserts shebang line" })

vim.keymap.set("n", "<leader>ts", function()
    local newTabSize = tonumber(vim.fn.input("New tab size: "))
    vim.opt.tabstop = newTabSize
    vim.opt.softtabstop = newTabSize
    vim.opt.shiftwidth = newTabSize
end)

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex, { desc = "[F]ile [E]xit", })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Move line below to the end of current line" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll [D]own" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll [U]p" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next item in find" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous item in find" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[S]earch and [R]eplace" })
vim.keymap.set("n", "<leader>sa", "ggVG", { desc = "[S]elect [A]ll" })

vim.keymap.set("n", "<leader>m", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "[M]ake it rain" })

vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<cr>", { desc = "Previous Quickfix Item" })

-- ------------------------------------------------------------------------------------------------
-- Splits -----------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<C-Up>", "<C-w>+", {})
vim.keymap.set("n", "<C-Down>", "<C-w>-", {})
vim.keymap.set("n", "<C-Left>", "<C-w><", {})
vim.keymap.set("n", "<C-Right>", "<C-w>>", {})

-- ------------------------------------------------------------------------------------------------
-- LSP --------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>sm', vim.cmd.ClangdSwitchSourceHeader, { desc = "[S]witch Between [M]odule Files" })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(event)
        local map = function(mapping, callback, description, mode)
            mode = mode or "n"
            vim.keymap.set(mode, mapping, callback, { buffer = event.buf, desc = description })
        end

        -- Formatting
        map("<leader>fo", vim.lsp.buf.format, "[F][o]rmat")

        local tb = require("telescope.builtin")
        local tbOpts = require("telescope.themes").get_ivy()
        local withOpts = function(callback, opts)
            return function()
                callback(opts)
            end
        end

        -- Diagnostics
        map("<leader>dw", vim.diagnostic.open_float, "View [D]iagnostics [W]indow")
        map("<leader>vd", withOpts(tb.diagnostics, tbOpts), "[V]iew [D]iagnostics Window")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")

        -- Workspace
        map("<leader>ws", withOpts(tb.lsp_workspace_symbols, tbOpts), "[W]orkspace [S]ymbol")
        map("<leader>ws", withOpts(tb.lsp_dynamic_workspace_symbols, tbOpts), "[W]orkspace [S]ymbol")
        map('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "[W]orkspace [L]ist Folder(s)")

        -- Navigation
        map("<leader>gr", withOpts(tb.lsp_references, tbOpts), "[G]o [R]eference(s)")
        map("<leader>gi", withOpts(tb.lsp_implementations, tbOpts), "[G]o [I]mplimentation(s)")
        map("<leader>gd", withOpts(tb.lsp_definitions, tbOpts), "[G]o [D]efinition(s)")
        map("<leader>gtd", withOpts(tb.lsp_type_definitions, tbOpts), "[G]o [T]ype [D]efinition(s)" )
        map("<leader>gts", withOpts(tb.lsp_document_symbols, tbOpts), "[G]o [T]o Document [S]ymbol(s)")

        -- Other
        map('K', vim.lsp.buf.hover, "Hover Documentation")
        map('<C-k>', vim.lsp.buf.signature_help, "Signature Help")
        map('<leader>rn', vim.lsp.buf.rename, "[R]e[n]ame")
        map('<leader>ca', vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "v" })
    end,
})
