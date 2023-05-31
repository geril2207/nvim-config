require("luasnip.loaders.from_vscode").load()
require("luasnip").filetype_extend("typescript", { "typescriptreact", "javascript", "javascriptreact" })
require("luasnip").filetype_extend("javascript", { "typescript", "javascriptreact" })
