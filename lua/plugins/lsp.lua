return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- "j-hui/fidget.nvim",
        "folke/lazydev.nvim",
        "RRethy/vim-illuminate",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("java").setup({
            jdk = {
                -- install jdk using mason.nvim
                auto_install = false,
                version = '24.0.1',
            },
        }
        )
        require("config.lsp")
    end,
}
