{
  den.aspects.shell.git = {
    homeManager = {pkgs, ...}: {
      programs = {
        git = {
          enable = true;
          settings = {
            user = {
              name = "Anton Shabat";
              email = "anton.shabat@gmail.com";
            };
            core = {
              editor = "nvim";
            };
            init = {
              defaultBranch = "main";
            };
          };
        };

        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };

        lazygit = {
          enable = true;
        };
      };

      programs.fish.shellAbbrs.lg = "lazygit";

      home.packages = [pkgs.git-crypt];
    };

    persist.home.files = [
      ".local/state/lazygit/state.yml"
      ".config/gh/hosts.yml"
    ];
  };
}
