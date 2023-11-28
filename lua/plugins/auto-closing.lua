return {
    "steelsojka/pears.nvim",
    config = function ()
        local R = require "pears.rule"
        require("pears").setup(function (conf)
            -- conf.preset "tag-matching"

            conf.pair("'", {
                close = "'",
                should_expand = R.any_of(
                    R.end_of_context "[a-zA-z0-9\\s]",
                    R.not_(R.start_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
            conf.pair('"', {
                close = '"',
                should_expand = R.any_of(
                    R.end_of_context "[a-zA-z0-9\\s]",
                    R.not_(R.start_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
            conf.pair("(", {
                close = ")",
                should_expand = R.any_of(
                    R.end_of_context "[a-zA-z0-9]"
                    -- R.not_(R.start_of_context "[a-zA-z0-9]")
                )
            })
            conf.pair("{", {
                close = "}",
                should_expand = R.any_of(
                    R.end_of_context "[a-zA-z0-9]"
                )
            })
        end)
    end
}
