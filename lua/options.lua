local options = {
  opt = {
	-- Editor
    breakindent = true, -- Wrap indent and have the same indent
    linebreak = true, -- Wrap lines at 'breakat'
    preserveindent = true, -- Preserve indent structure as much as possible
    expandtab = false, -- Enable the use of space in tab
    shiftwidth = 4, -- Number of space inserted for indentation
    tabstop = 4, -- Number of space in a tab
    infercase = true, -- Infer cases in keyword completion
    smartindent = true, -- Smarter autoindentation
    nrformats = 'alpha,octal,hex,bin', -- Enable ctrl+a/x incrementing and decrementing

	-- Visual
    -- cmdheight = 0, -- hide command line, it broke :(
    cursorline = true, -- Highlight the text line of the cursor
    number = true, -- Show numberline
    relativenumber = true, -- Show relative numberline
    showtabline = 0, -- always display tabline
    signcolumn = "yes", -- Always show the sign column
    termguicolors = true, -- Enable 24-bit RGB color in the TUI
    wrap = true, -- Disable wrapping of lines longer than the width of window
    list = true, -- Enable seeing tabs and spaces

	-- Completion
    completeopt = { "menuone", "noselect", "preview", "noinsert" }, -- Options for insert mode completion
    pumheight = 10, -- Height of the pop up menu

	-- Interaction
    mouse = "", -- Enable mouse support
    ignorecase = true, -- Case insensitive searching
    smartcase = true, -- But use sensitive if upper letter is typed
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    history = 100, -- Number of commands to remember in a history table
    undofile = true, -- Enable persistent undo
    writebackup = false, -- Disable making a backup before overwriting a file
    spelllang = { 'en' }, -- Use english dictionary

	-- Misc
    fileencoding = "utf-8", -- File content encoding for the buffer
    
	-- Statusline
-- 	statusline = (function()
-- 		local file_name = "%f"
-- 		local modified = "%m"
-- 		local align_right = "%="
-- 		local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
-- 		local fileformat = " [%{&fileformat}]"
-- 		local filetype = "%y"
-- 		local percentage = " %p%%"
-- 		local linecol = " %l:%c"
--  
-- 		return string.format(
-- 			"%s%s%s%s%s%s%s%s",
-- 			file_name,
-- 			modified,
-- 			align_right,
-- 			filetype,
-- 			fileencoding,
-- 			fileformat,
-- 			percentage,
-- 			linecol)
-- 	end)()
  },
  g = {
    mapleader = " ", -- set leader key

	-- Netrw
	netrw_keepdir = 0,
	netrw_winsize = 30,
	netrw_banner = 0,
  	netrw_localcopydircmd = 'cp -r',
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
