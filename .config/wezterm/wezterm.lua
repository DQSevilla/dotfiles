local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--[[ Font ]]
config.font_size = 17.6
local font_name =
	"BerkeleyMonoNerdFontMonoPlusFontAwesomePlusFontAwesomeExtensionPlusOcticonsPlusPowerSymbolsPlusCodiconsPlusPomiconsPlusFontLogosPlusMaterialDesignIconsPlusWeatherIcons"
config.font = wezterm.font(font_name)
config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Normal"
config.front_end = "OpenGL"
config.line_height = 1.0

--[[ Appearance ]]
config.color_scheme = "tokyonight_moon"
config.window_decorations = "NONE"
config.enable_scroll_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_frame = {
	font = wezterm.font({ family = font_name, weight = "Bold" }),
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.use_fancy_tab_bar = false

config.tab_max_width = 18

local function get_cwd(tab)
	local cwd = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return cwd == HOME_DIR and "." or cwd.file_path:gsub("(.*[/\\])(.*)", "%2")
end

-- https://github.com/folke/tokyonight.nvim/blob/81c867c5f638597a82c82094dcb90ed42444dabc/lua/tokyonight/colors.lua#L51
wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local ret = {
		none = "NONE",
		bg_dark = "#1e2030", --
		bg = "#222436", --
		bg_highlight = "#2f334d", --
		terminal_black = "#444a73", --
		fg = "#c8d3f5", --
		fg_dark = "#828bb8", --
		fg_gutter = "#3b4261",
		dark3 = "#545c7e",
		comment = "#7a88cf", --
		dark5 = "#737aa2",
		blue0 = "#3e68d7", --
		blue = "#82aaff", --
		cyan = "#86e1fc", --
		blue1 = "#65bcff", --
		blue2 = "#0db9d7",
		blue5 = "#89ddff",
		blue6 = "#b4f9f8", --
		blue7 = "#394b70",
		purple = "#fca7ea", --
		magenta2 = "#ff007c",
		magenta = "#c099ff", --
		orange = "#ff966c", --
		yellow = "#ffc777", --
		green = "#c3e88d", --
		green1 = "#4fd6be", --
		green2 = "#41a6b5",
		teal = "#4fd6be", --
		red = "#ff757f", --
		red1 = "#c53b53", --
	}

	local edge_background = ret.bg
	local background = ret.bg
	local foreground = ret.fg_gutter

	if tab.is_active then
		background = ret.blue
		foreground = ret.bg_dark
	elseif hover then
		background = ret.bg
		foreground = ret.fg
	end

	local edge_foreground = background

	local reserved_width = 6 -- index, zoom state, two separators, and two spaces
	local cwd = get_cwd(tab) -- TODO: do I want the cwd only or maybe neovim buffer too?
	if string.len(cwd) >= max_width - reserved_width then
		cwd = string.format("%s...", wezterm.truncate_right(cwd, max_width - reserved_width - 4))
	end

	local index = tonumber(tab.tab_index) + 1
	local zoomed = tab.active_pane.is_zoomed and "Z" or "F"

	local title = string.format(" %s•%s•%s ", index, cwd, zoomed)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

--[[ Key Bindings ]]

config.leader = { key = "a", mods = "CTRL" }

local act = wezterm.action
config.keys = {
	{
		key = "r",
		mods = "LEADER",
		action = act.ReloadConfiguration,
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "&",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return config
