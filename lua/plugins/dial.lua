return {
    "monaqa/dial.nvim",
    recommended = true,
    desc = "Increment and decrement numbers, dates, and more",
    -- stylua: ignore
    keys = {
        { "<C-a>",  function() return require('dial.map').inc_normal() end,  expr = true, desc = "Increment", mode = { "n", "v" } },
        { "<C-x>",  function() return require('dial.map').dec_normal() end,  expr = true, desc = "Decrement", mode = { "n", "v" } },
        { "g<C-a>", function() return require('dial.map').inc_gnormal() end, expr = true, desc = "Increment", mode = { "n", "v" } },
        { "g<C-x>", function() return require('dial.map').dec_gnormal() end, expr = true, desc = "Decrement", mode = { "n", "v" } },
    },
    opts = function()
        local augend = require("dial.augend")

        local logical_alias = augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
        })

        local ordinal_numbers = augend.constant.new({
            -- elements through which we cycle. When we increment, we go down
            -- On decrement we go up
            elements = {
                "first",
                "second",
                "third",
                "fourth",
                "fifth",
                "sixth",
                "seventh",
                "eighth",
                "ninth",
                "tenth",
            },
            -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
            word = false,
            -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
            -- Otherwise nothing will happen when there are no further values
            cyclic = true,
        })

        local weekdays = augend.constant.new({
            elements = {
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday",
            },
            word = true,
            cyclic = true,
        })

        local months = augend.constant.new({
            elements = {
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December",
            },
            word = true,
            cyclic = true,
        })

        local capitalized_boolean = augend.constant.new({
            elements = {
                "True",
                "False",
            },
            word = true,
            cyclic = true,
        })

        return {
            dials_by_ft = {
                javascript = "typescript",
                typescript = "typescript",
                typescriptreact = "typescript",
                javascriptreact = "typescript",
                json = "json",
                lua = "lua",
                markdown = "markdown",
                css = "css",
                sass = "css",
                scss = "css",
                python = "python",
            },
            groups = {
                default = {
                    augend.integer.alias.decimal,     -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
                    augend.integer.alias.hex,         -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"],    -- date (2022/02/19, etc.)
                    ordinal_numbers,
                    weekdays,
                    months,
                    capitalized_boolean,
                    augend.constant.alias.bool, -- boolean value (true <-> false)
                    logical_alias,
                    augend.semver.alias.semver, -- versioning (v1.1.2)
                    augend.hexcolor.new({ case = "prefer_lower" }),
                    augend.constant.new({
                        elements = { "and", "or" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    }),
                },
                markdown = {
                    augend.constant.new({
                        elements = { "[ ]", "[x]" },
                        word = false,
                        cyclic = true,
                    }),
                    augend.misc.alias.markdown_header,
                },
            },
        }
    end,
    config = function(_, opts)
        -- copy defaults to each group
        for name, group in pairs(opts.groups) do
            if name ~= "default" then
                vim.list_extend(group, opts.groups.default)
            end
        end
        require("dial.config").augends:register_group(opts.groups)
        vim.g.dials_by_ft = opts.dials_by_ft
    end,
}
