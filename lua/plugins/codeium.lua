return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "hrsh7th/nvim-cmp", enable = false },
    },
    config = function()
        require("codeium").setup({
        })
    end
}
