

-- GRUVBOX
local bg        = "#282828"
local bg0_h     = "#1d2021"
local fg        = "#ebdbb2"
local red1      = "#cc241d"
local red2      = "#fb4934"
local green1    = "#98971a"
local green2    = "#b8bb26"
local yellow1   = "#d79921"
local yellow2   = "#fabd2f"
local blue1     = "#458588"
local blue2     = "#83a598"
local purple1   = "#b16286"
local purple2   = "#d3869b"
local aqua1     = "#689d6a"
local aqua2     = "#8ec07c"
local gray1     = "#a89984"
local gray2     = "#928374"


return {
    groups = {
        background = bg0_h,
        background_nc = bg0_h,
        panel = bg0_h,
        panel_nc = bg0_h,
        border = fg,
        comment = 'muted',
        link = red2,
        punctuation = gray1,

        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',

        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
    },

    highlight_groups = {
        ColorColumn = { bg = aqua1 },

        -- Blend colours against the "base" background
        CursorLine = { bg = blue1, blend = 40 },
        StatusLine = { fg = yellow1, bg = yellow2, blend = 10 },

        -- By default each group adds to the existing config.
        -- If you only want to set what is written in this config exactly,
        -- you can set the inherit option:
        Search = { bg = 'gold', inherit = false },
        Function = { fg = 'gold' },
        -- local and such
        Statement = { fg = red1 },
        Keyword = { fg = red2 },

        DiagnosticStatusLineHint = {fg = 'love'},
        Type = { fg = green2 },
        Variable = { fg = blue1 },
        ['@field'] = { fg = 'foam'},
        ['@property'] = { fg = 'foam' },
        ['@parameter'] = { fg = fg, italic = true },
        ['String'] = { fg = green2, bold = false},
        ['DashboardHeader'] = { fg = red2},
    }
}
