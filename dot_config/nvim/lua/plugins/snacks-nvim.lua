--@type table
local opts = require("plugins.configs.snacks-nvim.opts")

---@type LazySpec
local spec = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local Snacks = require("snacks")
        Snacks.setup(opts)

        -- NOTE: user commands
        vim.api.nvim_create_user_command("ShowNotifyHistory", function()
            Snacks.notifier.show_history()
        end, {})
    end,
    --cond = false,
    --enabled = false,
}

return spec
