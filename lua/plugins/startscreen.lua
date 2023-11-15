return {
    'nvimdev/dashboard-nvim',
    -- event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
            -- theme = "hyper",
            config = {
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                },
                project = { enable = false },
                packages = { enable = true },
                mru = { limit = 5, icon = '', label = 'Latest files', cwd_only = true },
                footer = {},
            }
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
