{
  program = {
    enable = true;

    publicKeys = [
      { source = ./gmail.asc; }
      { source = ./speely.asc; }
    ];
  };
}
