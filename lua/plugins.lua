return {
    {
        'ShinKage/idris2-nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' },
        event = "VeryLazy",
        config = function()
            require('idris2').setup({})
        end
    },


    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "nvim-lua/plenary.nvim" },
    { "alec-gibson/nvim-tetris",         event = "VeryLazy" },
    { 'eandrju/cellular-automaton.nvim', event = "VeryLazy" },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({ options = { theme = 'gruvbox-material' } })
        end
    },

    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_transparent_background = 2

            vim.cmd.colorscheme('gruvbox-material')
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

--    {
--        "norcalli/nvim-colorizer.lua",
--        config = function()
--            require("colorizer").setup()
--        end,
--    },

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

    {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
}

}
