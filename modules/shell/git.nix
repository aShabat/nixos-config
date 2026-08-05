{
  den.aspects.git = {
    homeManager = {pkgs, ...} : {
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

        lazygit = {
          enable = true;
        };
      };

      home.packages = [ pkgs.git-crypt ];
    };
  };
}
