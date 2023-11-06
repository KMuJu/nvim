return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            local colors = require("core.colors")
            require('rose-pine').setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = 'moon',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = 'moon',
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = false,
                disable_float_background = false,
                disable_italics = false,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = colors.groups,

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = colors.highlight_groups
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = 'gruvbox',
        priority = 1000,
        config = true,
        opts = ...
    },
}
