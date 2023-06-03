local config = require("metals").bare_config()

config.capabilities = require("cmp_nvim_lsp").default_capabilities()

config.on_attach = function(client, bufnr)
	On_attach(client, bufnr)
end

require("metals").initialize_or_attach(config)
