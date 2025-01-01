{ currentSystem, pkgs }: {
  packages = if currentSystem == "linux"
  then with pkgs; [ trashy ]
  else [];

  aliases = {
    rm = "echo 'Are you sure you didn\\'t mean `trash`?'";
  };
}
