---@type table
local opts = {
    -- TODO: opts
}

---@type LazySpec
local spec = {
    "leonardo-luz/tetris.nvim",
    --lazy = false,
    cmd = "Tetris",
    dependencies = { "leonardo-luz/floatwindow.nvim" },
    opts = opts,
    --cond = false,
    --enabled = false,
}

return spec