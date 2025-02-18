{
  description = "config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
		hyprland.url = "github:hyprwm/Hyprland";
		rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
				specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
