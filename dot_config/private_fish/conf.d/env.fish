set -g fish_greeting # Disable fish greeting 
set -Ux EDITOR nvim
set -Ux LC_ALL ru_RU.UTF-8
set -Ux FISH_CONFIG_PATH $__fish_config_dir/config.fish

# Add my custom functions to be autoloaded
if test -d $__fish_config_dir/custom_functions.d
  set -gp fish_function_path $__fish_config_dir/custom_functions.d
end

if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
else if type -q vim
  set -gx EDITOR vim
  set -gx VISUAL vim
else
  set -gx EDITOR vi
  set -gx VISUAL vi
end

if type -q bat
  set -Ux BAT_THEME Monokai Extended Bright # Set theme for BAT
end

if type -q fzf
  set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
end

set -Ux MIKROTIK_SSH_CREDENTIALS admin@router.lan
set -Ux MIKROTIK_VPN_NAME full_vpn
