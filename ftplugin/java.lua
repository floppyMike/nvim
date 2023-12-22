local on_attach = function(client, bufnr)
	require('jdtls.setup').add_commands()

	on_attach(client, bufnr)

	vim.keymap.set('n', '<F7>', ':!mvn exec:java -Dexec.mainClass=""', { buffer = bufnr })
	vim.keymap.set('n', '<F8>', '<cmd>!mvn clean test<CR>', { buffer = bufnr })
end

local config = {
	cmd = {
		'jdt-language-server', '-data', '/tmp/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
	},

	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),

	on_attach = on_attach,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
		}
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {}
	},
}

require('jdtls').start_or_attach(config)
