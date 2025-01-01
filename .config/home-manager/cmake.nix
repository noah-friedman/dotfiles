{ pkgs }:
{
  packages = with pkgs; [
    cmakeCurses
  ];
  aliases = {
    ccmake = "ccmake -S . -B build";
  };
  env = {
    CMAKE_EXPORT_COMPILE_COMMANDS = 1;
  };
}
