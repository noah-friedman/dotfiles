{ ... }: {
  onyx = old: {
    src = builtins.fetchurl {
      url = "https://www.titanium-software.fr/download/15/OnyX.dmg";
      sha256 = "0097bb9n4dc9400fa6iqy29y7lwykamws4pr34nfkqfr2rmfjwd6";
    };
    meta.broken = false;
  };
}
