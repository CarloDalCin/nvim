return {
    dir = "~/dev/euler-nvim",
    enabled = false,
    name = "euler",
    build = "make build",
    config = function()
        require("euler").setup({

        })
    end
}
