return {
    "steelsojka/pears.nvim",
    config = function ()
        local R = require "pears.rule"
        require("pears").setup(function (conf)
            -- conf.preset "tag-matching"

            conf.pair("'", {
                close = "'",
                should_expand = R.all_of(
                    R.not_(R.end_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
            conf.pair('"', {
                close = '"',
                should_expand = R.all_of(
                    R.not_(R.end_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
            conf.pair("(", {
                close = ")",
                should_expand = R.all_of(
                    R.not_(R.end_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
            conf.pair("{", {
                close = "}",
                should_expand = R.all_of(
                    R.not_(R.end_of_context "[a-zA-z0-9]"),
                    R.not_(R.child_of_node {"string"})
                )
            })
        end)
    end
}
