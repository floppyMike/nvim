local M = {}

function M.set_hl(c)
	local groups = {
		-- Base.
		Normal = { fg = c.fg, bg = c.bg },
		NormalFloat = { bg = c.bg },
		FloatBorder = { fg = c.comment },
		FloatTitle = { fg = c.fg },
		ColorColumn = { bg = c.line },
		Cursor = { fg = c.bg, bg = c.cursor },
		CursorColumn = { bg = c.line },
		CursorLine = { bg = c.line },
		CursorLineNr = { fg = c.indicator, bg = c.line, bold = true },
		LineNr = { fg = c.line_nr, bg = c.gutter_bg },

		Directory = { fg = c.func },
		ErrorMsg = { fg = c.error },
		OkMsg = { fg = c.ok },
		WinSeparator = { fg = c.gutter_normal, bg = c.bg },
		Folded = { fg = c.fg_idle, bg = c.panel_bg },
		SignColumn = { bg = c.gutter_bg },

		MatchParen = { sp = c.func, underline = true },
		ModeMsg = { fg = c.string },
		MoreMsg = { fg = c.string },
		NonText = { fg = c.guide_normal },
		Pmenu = { fg = c.fg, bg = c.selection_inactive },
		PmenuSel = { fg = c.fg, bg = c.selection_inactive, reverse = true },
		PmenuSbar = { bg = c.line },
		PmenuThumb = { bg = c.guide_normal },
		PmenuKind = { fg = c.entity, bg = c.selection_inactive },
		PmenuExtra = { fg = c.lsp_inlay_hint, bg = c.selection_inactive },
		PmenuMatch = { fg = c.accent, bg = c.selection_inactive, bold = true },
		PmenuMatchSel = { fg = c.accent, bg = c.selection_inactive, reverse = true, bold = true },
		ComplMatchIns = { fg = c.fg_idle },
		Question = { fg = c.string },
		Search = { fg = c.bg, bg = c.func },
		CurSearch = { fg = c.bg, bg = c.warning, bold = true },
		Substitute = { link = 'CurSearch' },
		YankFlash = { fg = c.bg, bg = c.accent },
		SpecialKey = { fg = c.gutter_normal },
		Whitespace = { fg = c.selection_inactive },
		SpellCap = { sp = c.tag, undercurl = true },
		SpellLocal = { sp = c.keyword, undercurl = true },
		SpellBad = { sp = c.error, undercurl = true },
		SpellRare = { sp = c.regexp, undercurl = true },
		StatusLine = { fg = c.fg, bg = c.panel_bg },
		StatusLineNC = { fg = c.fg_idle, bg = c.panel_bg },
		TermCursor = { fg = c.bg, bg = c.accent },
		WildMenu = { fg = c.bg, bg = c.accent, bold = true },
		MsgArea = { fg = c.fg },
		MsgSeparator = { fg = c.gutter_normal, bg = c.panel_bg },
		WinBar = { fg = c.fg, bg = c.panel_bg, bold = true },
		WinBarNC = { fg = c.fg_idle, bg = c.panel_bg },
		TabLine = { fg = c.comment, bg = c.panel_shadow },
		TabLineFill = { fg = c.fg, bg = c.panel_border },
		TabLineSel = { fg = c.fg, bg = c.bg },
		Title = { fg = c.keyword },
		Visual = { bg = c.selection_inactive },
		WarningMsg = { fg = c.warning },
		QuickFixLine = { fg = c.accent },

		Comment = { fg = c.comment, italic = true },
		Constant = { fg = c.constant },
		String = { fg = c.string },
		Identifier = { fg = c.entity },
		Function = { fg = c.func },
		Statement = { fg = c.keyword, bold = true },
		Operator = { fg = c.operator },
		Exception = { fg = c.markup },
		PreProc = { fg = c.accent },
		Type = { fg = c.entity },
		Structure = { fg = c.special },
		Special = { fg = c.accent },
		Delimiter = { fg = c.special },
		Underlined = { sp = c.tag, underline = true },
		Ignore = { fg = c.fg },
		Error = { fg = c.white, bg = c.error },
		Todo = { fg = c.markup },
		qfLineNr = { fg = c.keyword },
		qfError = { fg = c.error },
		Conceal = { fg = c.comment },
		CursorLineConceal = { fg = c.guide_normal, bg = c.line },

		Added = { fg = c.vcs_added },
		Removed = { fg = c.vcs_removed },
		Changed = { fg = c.vcs_modified },
		DiffAdd = { bg = c.vcs_added_bg },
		DiffAdded = { fg = c.vcs_added },
		DiffDelete = { bg = c.vcs_removed_bg },
		DiffRemoved = { fg = c.vcs_removed },
		DiffText = { bg = c.gutter_normal },
		DiffChange = { bg = c.selection_inactive },

		-- LSP.
		DiagnosticError = { fg = c.error },
		DiagnosticWarn = { fg = c.warning },
		DiagnosticInfo = { fg = c.accent },
		DiagnosticHint = { fg = c.regexp },
		DiagnosticOk = { fg = c.ok },

		DiagnosticUnderlineError = { sp = c.error, undercurl = true },
		DiagnosticUnderlineWarn = { sp = c.warning, undercurl = true },
		DiagnosticUnderlineInfo = { sp = c.accent, undercurl = true },
		DiagnosticUnderlineHint = { sp = c.regexp, undercurl = true },
		DiagnosticUnderlineOk = { sp = c.ok, undercurl = true },

		DiagnosticUnnecessary = { fg = c.fg_idle },
		DiagnosticDeprecated = { sp = c.fg_idle, strikethrough = true },

		LspInlayHint = { fg = c.lsp_inlay_hint },
		LspSignatureActiveParameter = { italic = true },
		LspReferenceWrite = { bg = c.selection_inactive, underline = true },
		LspCodeLens = { fg = c.comment, italic = true },
		LspCodeLensSeparator = { fg = c.guide_normal },

		-- Dap sign column. plugin/debugging.lua points its signs at the Diagnostic groups.
		debugPC = { bg = c.line },
		debugBreakpoint = { fg = c.error },

		-- Markdown.
		markdownCode = { fg = c.special },

		-- TreeSitter.
		['@property'] = { fg = c.tag },
		['@tag'] = { fg = c.keyword },
		['@tag.attribute'] = { fg = c.entity },
		['@tag.delimiter'] = { link = 'Delimiter' },
		['@type.qualifier'] = { fg = c.keyword },
		['@variable'] = { fg = c.fg },
		['@variable.builtin'] = { fg = c.func },
		['@variable.member'] = { fg = c.tag },
		['@variable.parameter'] = { fg = c.lsp_parameter },
		['@module'] = { fg = c.entity },
		['@keyword.storage'] = { fg = c.keyword },
		['@function.builtin'] = { link = 'Statement' },

		-- Only the semantic tokens that differ from their default link.
		['@lsp.type.parameter'] = { fg = c.lsp_parameter },
		['@lsp.type.field'] = { link = '@variable.member' },
		['@lsp.type.macro'] = { link = '@function.macro' },
		['@lsp.type.decorator'] = { link = '@function' },
		['@lsp.mod.constant'] = { link = '@constant' },
		['@lsp.typemod.function.constant'] = { link = '@function' },
		['@lsp.typemod.method.constant'] = { link = '@function' },

		-- TreesitterContext.
		TreesitterContext = { bg = c.selection_inactive },

		-- Word under cursor.
		CursorWord = { bg = c.selection_inactive },
		CursorWord0 = { link = 'CursorWord' },
		CursorWord1 = { link = 'CursorWord' },

		-- Dap.
		NvimDapVirtualText = { fg = c.regexp },

		-- DAP UI.
		DapUIScope = { fg = c.func },
		DapUIType = { fg = c.entity },
		DapUIDecoration = { fg = c.tag },
		DapUIThread = { fg = c.string },
		DapUIStoppedThread = { fg = c.special },
		DapUISource = { fg = c.regexp },
		DapUILineNumber = { fg = c.constant },
		DapUIFloatBorder = { link = 'FloatBorder' },
		DapUIWatchesEmpty = { fg = c.warning },
		DapUIWatchesValue = { fg = c.string },
		DapUIWatchesError = { fg = c.error },
		DapUIBreakpointsPath = { fg = c.regexp },
		DapUIBreakpointsInfo = { fg = c.constant },
		DapUIBreakpointsCurrentLine = { fg = c.constant, bold = true },

		-- Mini.
		MiniCompletionInfoBorderOutdated = { fg = c.warning },

		MiniDiffSignAdd = { fg = c.vcs_added },
		MiniDiffSignChange = { fg = c.vcs_modified },
		MiniDiffSignDelete = { fg = c.vcs_removed },

		MiniFilesNormal = { link = 'NormalFloat' },
		MiniFilesBorder = { link = 'FloatBorder' },
		MiniFilesBorderModified = { fg = c.warning },
		MiniFilesCursorLine = { bg = c.selection_inactive },
		MiniFilesDirectory = { fg = c.func },
		MiniFilesFile = { fg = c.fg },
		MiniFilesTitle = { fg = c.comment },
		MiniFilesTitleFocused = { fg = c.accent, bold = true },

		MiniNotifyNormal = { link = 'NormalFloat' },
		MiniNotifyBorder = { link = 'FloatBorder' },
		MiniNotifyTitle = { fg = c.accent, bold = true },
		MiniNotifyLspProgress = { fg = c.comment },

		MiniPickNormal = { link = 'NormalFloat' },
		MiniPickBorder = { link = 'FloatBorder' },
		MiniPickBorderBusy = { fg = c.warning },
		MiniPickBorderText = { fg = c.accent },
		MiniPickHeader = { fg = c.regexp },
		MiniPickIconDirectory = { fg = c.func },
		MiniPickIconFile = { fg = c.comment },
		MiniPickMatchCurrent = { bg = c.line },
		MiniPickMatchMarked = { bg = c.selection_inactive },
		MiniPickMatchRanges = { fg = c.accent, bold = true },
		MiniPickPreviewLine = { bg = c.line },
		MiniPickPreviewRegion = { bg = c.selection_inactive },
		MiniPickPrompt = { fg = c.keyword, bold = true },
		MiniPickPromptCaret = { fg = c.cursor },
		MiniPickPromptPrefix = { fg = c.accent },
		MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
		MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
		MiniHipatternsTodo = { fg = c.bg, bg = c.accent, bold = true },
		MiniHipatternsNote = { fg = c.bg, bg = c.regexp, bold = true },
		MiniIconsAzure = { fg = c.vcs_modified },
		MiniIconsBlue = { fg = c.accent },
		MiniIconsCyan = { fg = c.func },
		MiniIconsGreen = { fg = c.ok },
		MiniIconsGrey = { fg = c.comment },
		MiniIconsOrange = { fg = c.warning },
		MiniIconsPurple = { fg = c.markup },
		MiniIconsRed = { fg = c.error },
		MiniIconsYellow = { fg = c.regexp },
		MiniIndentscopeSymbol = { fg = c.comment },
		MiniIndentscopeSymbolOff = { fg = c.keyword },
		MiniJump = { sp = c.keyword, undercurl = true },
		MiniJump2dDim = { fg = c.comment, nocombine = true },
		MiniJump2dSpot = { fg = c.keyword, bold = true, underline = true, nocombine = true },
		MiniJump2dSpotAhead = { fg = c.entity, underline = true, nocombine = true },
		MiniJump2dSpotUnique = { fg = c.tag, bold = true, underline = true, nocombine = true },
		MiniMapNormal = { fg = c.lsp_inlay_hint, bg = c.panel_bg },
		MiniStarterItemPrefix = { fg = c.accent },
		MiniStarterFooter = { link = 'Comment' },
		MiniStatuslineDevinfo = { fg = c.fg, bg = c.panel_border },
		MiniStatuslineFileinfo = { fg = c.fg, bg = c.panel_border },
		MiniStatuslineFilename = { fg = c.fg_idle, bg = c.panel_border },
		MiniStatuslineInactive = { fg = c.fg_idle, bg = c.panel_border },
		MiniTablineCurrent = { fg = c.fg, bg = c.bg, bold = true },
		MiniTablineFill = { fg = c.fg, bg = c.panel_border },
		MiniTablineHidden = { fg = c.comment, bg = c.panel_shadow },
		MiniTablineModifiedCurrent = { fg = c.accent, bg = c.bg, bold = true },
		MiniTablineModifiedHidden = { fg = c.accent, bg = c.bg },
		MiniTablineModifiedVisible = { fg = c.accent, bg = c.bg },
		MiniTablineVisible = { fg = c.fg, bg = c.bg },
		MiniTablineTabpagesection = { fg = c.bg, bg = c.indicator, bold = true },
		MiniTestFail = { fg = c.error, bold = true },
		MiniTestPass = { fg = c.ok, bold = true },
		MiniTrailspace = { bg = c.vcs_removed },

		-- Render Markdown.
		RenderMarkdownQuote = { fg = c.accent },
		RenderMarkdownBullet = { fg = c.accent },
		RenderMarkdownDash = { fg = c.accent },
		RenderMarkdownSign = { fg = c.accent },
		RenderMarkdownMath = { fg = c.accent },
		RenderMarkdownIndent = { fg = c.accent },
		RenderMarkdownHtmlComment = { fg = c.comment },
		RenderMarkdownLink = { fg = c.tag },
		RenderMarkdownWikiLink = { fg = c.tag },
		RenderMarkdownUnchecked = { fg = c.markup },
		RenderMarkdownChecked = { fg = c.ok },
		RenderMarkdownTodo = { fg = c.ok },
		RenderMarkdownTableHead = { fg = c.comment },
		RenderMarkdownTableRow = { fg = c.comment },
		RenderMarkdownTableFill = { fg = c.comment },

		-- HTML.
		htmlTag = { fg = c.entity },
		htmlEndTag = { link = 'htmlTag' },
		htmlTagName = { link = 'htmlTag' },
		htmlArg = { fg = c.func },
		htmlTitle = { bold = true, fg = c.fg },
	}

	-- Families whose members differ only by index. Reorder a list to retheme the whole run.
	local heading = { c.vcs_added, c.string, c.accent, c.keyword, c.markup, c.constant }
	local quote = { c.accent, c.keyword, c.markup, c.constant, c.constant, c.constant }
	local csv = { c.accent, c.regexp, c.markup, c.constant, c.func, c.string, c.vcs_added, c.warning }

	for i, fg in ipairs(heading) do
		groups['RenderMarkdownH' .. i] = { fg = fg }
		groups['RenderMarkdownH' .. i .. 'Bg'] = { fg = fg, bg = c.line }
		groups['RenderMarkdownQuote' .. i] = { fg = quote[i] }
		groups['htmlH' .. i] = { link = 'htmlTitle' }
	end

	for i, fg in ipairs(csv) do groups['csvCol' .. i] = { fg = fg } end

	for _, mode in ipairs { 'Command', 'Insert', 'Normal', 'Other', 'Replace', 'Visual' } do
		groups['MiniStatuslineMode' .. mode] = { fg = c.bg, bg = c.indicator, bold = true }
	end

	for group, parameters in pairs(groups) do
		vim.api.nvim_set_hl(0, group, parameters)
	end

	-- ANSI palette for :terminal, so shell output sits in the same range as the editor.
	local ansi = {
		c.bg, c.error, c.ok, c.warning, c.accent, c.markup, c.regexp, c.fg,
		c.comment, c.vcs_removed, c.vcs_added, c.warning, c.func, c.markup, c.string, c.special,
	}

	for i, colour in ipairs(ansi) do vim.g['terminal_color_' .. (i - 1)] = colour end

	vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:-Cursor"
end

return M
