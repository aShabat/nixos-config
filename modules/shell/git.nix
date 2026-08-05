{
  den.aspects.git = {
    homeManager.programs.git = {
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
    homeManager.programs.lazygit = {
      enable = true;
    };
  };
}
