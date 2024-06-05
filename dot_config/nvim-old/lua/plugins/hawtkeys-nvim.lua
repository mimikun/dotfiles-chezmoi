---@type table
local cmds = {
    "Hawtkeys",
    "HawtkeysAll",
    "HawtkeysDupes",
}

---@type LazySpec
local spec = {
    "tris203/hawtkeys.nvim",
    --lazy = false,
    --event = "VeryLazy",
    cmd = cmds,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    --cond = false,
}

return spec
