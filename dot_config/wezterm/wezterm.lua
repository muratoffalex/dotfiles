-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Increase font size
-- Listener for zen-mode.nvim plugin
wezterm.on("user-var-changed", function(window, pane, name, value)
    wezterm.log_info("var", name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    window:set_config_overrides(overrides)
end)

local config = wezterm.config_builder()

-- Contrasting color scheme
config.color_scheme = "deep"
config.enable_tab_bar = false
config.enable_scroll_bar = false
-- Comfortable opacity with blur
config.window_background_opacity = 0.85
config.macos_window_background_blur = 35
-- Remove all decorations
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
-- Enable wezterm full mode (faster)
config.native_macos_fullscreen_mode = false
-- Don't adjust window size when changing font size
config.adjust_window_size_when_changing_font_size = false

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_size = 18
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligatures

config.window_padding = {
    left = "1.5cell",
    right = "1.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
}

config.keys = {
    -- open t - tmux smart session manager <ctrl+a>T
    { key = "j", mods = "CMD", action = wezterm.action.SendString("\x01\x54") },
		-- open sesh gum <Ctrl-a>K
    { key = "j", mods = "CMD", action = wezterm.action.SendString("\x01\x4b") },
}

return config
