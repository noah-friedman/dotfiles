{ pkgs, ... }: {
  programs.git = {
    enable = true;
    
    extraConfig = {
      core.editor = "nvim";
      push.autoSetupRemote = true;
    };
    ignores = if pkgs.stdenv.isDarwin
              then [".DS_Store"]
              else [];
    signing = {
      key = null;
      signByDefault = true;
    };
    userEmail = "speelbarrow@speely.net";
    userName = "Noah Friedman";
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      { source = ./gmail.pub.asc; }
      { source = ./speely.pub.asc; }
    ];
  };
}
