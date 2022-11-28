
require("luasnip.loaders.from_vscode").load()
require'luasnip'.filetype_extend("typescript", {"typescriptreact", "javascript"})
require'luasnip'.filetype_extend("javasript", {"typescript"})
