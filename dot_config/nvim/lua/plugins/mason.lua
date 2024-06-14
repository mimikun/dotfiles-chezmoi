local global = require("core.global")
local iconsets = require("utils.icons")

---@type table
local icons = {
    kind = iconsets.get("kind"),
    documents = iconsets.get("documents"),
    ui = iconsets.get("ui"),
    ui_sep = iconsets.get("ui", true),
    misc = iconsets.get("misc"),
}

-- Limit the number of concurrent task depending on human rights or OS
---@type number|function limit the maximum amount of concurrent tasks
local concurrency_limit_check = function()
    local limit
    if global.is_human_rights then
        limit = 4
    else
        limit = 1
    end
    return limit
end

---@type number
local concurrency = concurrency_limit_check()

---@type table
local dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "zapling/mason-lock.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
}

---@type LazySpec
local spec = {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = dependencies,
    config = function()
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        require("neoconf").setup({})
        require("neodev").setup({})


        local handlers = {
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                })
            end,

            ["lua_ls"] = function()
                lspconfig.lua_ls.setup(require("plugins.lsp.lua-ls"))
            end,
        }

        if not configs.fish_lsp then
            configs.fish_lsp = require("plugins.lsp.fish-lsp")
        end

        -- TODO: aiscript-lsp
        -- NOTE: about :h lspconfig-setup
        if not configs.aiscript_lsp then
            configs.aiscript_lsp = {
                default_config = {
                    root_dir = lspconfig.util.root_pattern("*.is", "*.ais"),
                    name = "aiscript-lsp",
                    filetypes = { "is", "ais" },
                    autostart = true,
                    single_file_support = true,
                    --on_new_config = function(new_config, new_root_dir) end,
                    --capabilities = {},
                    cmd = { "aiscript-languageserver", "--stdio" },
                    --handlers = {},
                    --init_options = {},
                    --on_attach = function(client, bufnr)end,
                    settings = {},
                },
            }
        end

        require("mason").setup({
            max_concurrent_installers = concurrency,
            ui = {
                check_outdated_packages_on_open = true,
                border = "rounded",
                width = 0.88,
                height = 0.8,
                icons = {
                    package_installed = icons.ui.Check,
                    package_pending = icons.misc.Ghost,
                    package_uninstalled = icons.kind.Close,
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = require("plugins.sources.servers").need_servers,
            handlers = handlers,
        })
        lspconfig.fish_lsp.setup({})
        lspconfig.aiscript_lsp.setup({})
        require("mason-lock").setup({
            lockfile_path = global.mason_lockfile,
        })
    end,
    --cond = false,
}

return spec
