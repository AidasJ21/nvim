return {
    { 'mason-org/mason.nvim', version = "^1.0.0" },
    { 'mason-org/mason-lspconfig.nvim', version = "^1.0.0" },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'clangd',
                    'pylsp',
                    'rust_analyzer',
                    'gopls',
                    --'hls',
                    'zls',
                    "vimls",
                },
            })


            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    vim.lsp.enable(server_name)
                end,
            })

            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup({})

            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', group_index = 1 },
                    { name = 'buffer',   group_index = 2 },
                    { name = 'path',     group_index = 3 },
                    { name = 'luasnip',  group_index = 4 },
                }),
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert,noselect,preview'
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    ['<Tab>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    },
                    ['<S-Tab>'] = function()
                        luasnip.jump(1)
                    end
                }),
            })
        end
    },
}
