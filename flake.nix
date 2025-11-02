{
  description = " Here you go, my keys!! and all the powers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      # url = "github:ryantm/agenix";
      url = "github:yaxitech/ragenix";
    };

  };

  outputs =
    { self, ... }:
    let
      allSystems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems =
        f:
        self.inputs.nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import self.inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          }
        );
    in
    {
      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages =
              (with pkgs; [
                git
                nixd
              ])
              ++ [
                self.inputs.agenix.packages.${pkgs.system}.default
                self.output.formatter.${pkgs.system}
              ];
          };
        }
      );
      formatter = forAllSystems ({ pkgs }: pkgs.alejandra);
    };
}
