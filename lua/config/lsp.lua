local status, lsp = pcall(require, "lspconfig")
if not status then
    return
end

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- library = lualib,
                    -- library = {
                    -- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    -- 	[vim.fn.stdpath("config") .. "/lua"] = true,
                    -- },
                    library = vim.api.nvim_get_runtime_file("lua", true),
                },
            },
        },
    },
    pyright = {},
    clangd = {
        -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
        -- TODO: Could include cmd, but not sure those were all relevant flags.
        --    looks like something i would have added while i was floundering
        init_options = { clangdFileStatus = true },

        filetypes = { "c", "cpp" },
    },

    ts_ls = {
        server_capabilities = {
            documentFormattingProvider = false,
        },
    },
    svelte = {},
    html = {},
    cssls = {},
    cmake = {},
    bashls = {},
    ocamllsp = {
        settings = {
            codelens = { enable = true },
            inlayHints = { enable = true },
            syntaxDocumentation = { enable = true },
        },
        cmd = { "ocamllsp" },
        filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
        root_dir = lsp.util.root_pattern(
            "*.opam",
            "esy.json",
            "package.json",
            ".git",
            "dune-project",
            "dune-workspace"
        ),
    },

    jdtls = {
        settings = {
            java = {
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-21",
                            path = "/usr/sbin/java",
                            default = true,
                        }
                    }
                }
            }
        }
    },         -- java
    lemminx = {}, --

    gopls = {},
    dockerls = {},
    templ = {},
    elixirls = {
        cmd = { "/home/Kasper/.local/share/nvim/mason/bin/elixir-ls" },
        root_dir = require("lspconfig.util").root_pattern({ "mix.exs" }),
        server_capabilities = {
            -- completionProvider = true,
            -- definitionProvider = false,
            documentFormattingProvider = false,
        },
    },
}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

-- Set up cool signs for diagnostics
local signs = { Error = "E ", Warn = " ", Hint = "H ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostic config
vim.diagnostic.config(require("custom.functions.diagnostics").diag1)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")
for name, config in pairs(servers) do
    if config == true then
        config = {}
    end
    config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
    }, config)

    lspconfig[name].setup(config)
end

local on_attach = function(bufnr, client)
    local lsp_map = require("helpers.keys").lsp_map
    lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
    lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
    lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
    lsp_map("<leader>ls", require("fzf-lua").lsp_document_symbols, bufnr, "Document symbols")
    -- lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

    lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
    lsp_map("gr", require("fzf-lua").lsp_references, bufnr, "Goto References")
    lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
    lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
    lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

    -- Inlay hints
    lsp_map("<leader>lh", function()
        lsp.inlay_hint.enable(0, not lsp.inlay_hint.is_enabled())
    end, bufnr, "Toggle inline [H]ints")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")
    require("helpers.keys").map("v", "<leader>fv", vim.lsp.buf.format, "Format selection")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    -- Attach and configure vim-illuminate
    require("illuminate").on_attach(client)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        on_attach(bufnr, client)
    end,
})
