require "pluginmanager".ensure("ggandor", "leap.nvim", {}, function()
	require 'leap'.add_default_mappings()
end)
