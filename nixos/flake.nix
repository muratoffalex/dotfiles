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
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    neovim-nightly-overlay.url = "github:muratoffalex/neovim-nightly-overlay";
  };

  outputs =
    { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.muratoffalex = import ./home/default.nix;
            }
          ];
        };
      };
    };
}
