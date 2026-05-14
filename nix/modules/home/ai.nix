{ pkgs, inputs, ... }:
{
  imports = [ inputs.peon-ping.homeManagerModules.default ];

  home.packages = with pkgs; [
    aider-chat
    aichat
    opencode
    codex-acp
    inputs.codex.packages.${system}.default
    inputs.claude-code.packages.${system}.default
    inputs.claude-agent-acp.packages.${system}.default
    inputs.peon-ping.packages.${pkgs.system}.default
  ];

  programs.peon-ping = {
    enable = true;
    package = inputs.peon-ping.packages.${pkgs.system}.default;
    claudeCodeIntegration = true;

    settings = {
      default_pack = "anime-girls";
      volume = 0.7;
      enabled = true;
      desktop_notifications = true;
      categories = {
        "session.start" = true;
        "task.complete" = true;
        "task.error" = true;
        "input.required" = true;
        "resource.limit" = true;
        "user.spam" = true;
      };
    };

    installPacks = [
      "peon_ru"
      {
        name = "anime-girls";
        src = pkgs.fetchFromGitHub {
          owner = "maluramichael";
          repo = "openpeon-anime-girls";
          rev = "master";
          sha256 = "sha256-4U8wJyC6JjuZ/GsXz3TnRR0ik+bmrAOqIInmKVv/SA0=";
        };
      }
    ];
  };
}
