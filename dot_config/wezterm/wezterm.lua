-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

-- Contrasting color scheme
config.color_scheme = "deep"
config.enable_tab_bar = false
config.enable_scroll_bar = false
-- Comfortable opacity with blur
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
-- Remove all decorations
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
-- Enable wezterm full mode (faster)
config.native_macos_fullscreen_mode = false

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_size = 13
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures

-- Window frame settings (when tab bar enabled)
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold" }),
	active_titlebar_bg = "none",
	inactive_titlebar_bg = "rgba(0% 0% 0% 0%)",
	font_size = 12.0,
}

config.window_padding = {
	left = "1.5cell",
	right = "1.5cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

return config
