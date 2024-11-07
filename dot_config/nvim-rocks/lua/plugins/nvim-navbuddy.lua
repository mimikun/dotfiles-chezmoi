---@type table
local opts = {
    window = {
        border = "rounded",
    },
    lsp = {
        auto_attach = true,
    },
}

require("nvim-navbuddy").setup(opts)