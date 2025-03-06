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
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=release-24.11";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "github:muratoffalex/zen-browser-flake";
    neovim-nightly-overlay.url = "github:muratoffalex/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, nixpkgs-unstable-small, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      pkgs-unstable-small = nixpkgs-unstable-small.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit pkgs-unstable-small;
          };
          modules = [
            ./hosts/main
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit pkgs-stable;
                inherit pkgs-unstable-small;
              };
              home-manager.users.muratoffalex = import ./home/muratoffalex;
            }
          ];
        };
      };
    };
}
