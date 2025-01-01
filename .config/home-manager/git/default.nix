{
  program = {
    enable = true;

    signing = {
	key = null;
    	signByDefault = true;
    };

    userEmail = "speelbarrow@speely.net";
    userName = "Noah Friedman";
  };

  gpg.program = {
    enable = true;

    publicKeys = [
      { source = ./gmail.asc; }
      { source = ./speely.asc; }
    ];
  };
}
