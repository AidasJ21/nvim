return {
    { "folke/which-key.nvim" },
    { "folke/neodev.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "alec-gibson/nvim-tetris", event = "VeryLazy" },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({})
        end
    },

    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                disable_float_background = true,
            })
            vim.cmd('colorscheme rose-pine')
        end
    },

    {
        'mbbill/undotree',
        event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "[U]ndotree [T]oggle" })
            vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus, { desc = "[U]ndotree [F]ocus" })
        end,
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
        end
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',

            "L3MON4D3/LuaSnip",
        },
    },

}
