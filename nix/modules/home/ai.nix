{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    aider-chat
    aichat
    inputs.mcp-hub.packages."${system}".default
    claude-code
    claude-code-acp
  ];
}
