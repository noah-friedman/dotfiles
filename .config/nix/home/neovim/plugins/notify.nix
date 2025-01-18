{ ... }: {
  notify = {
    enable = true;
    fps = 60;
    # Must set explicitly or bold highlight won't work
    render = "default";
    stages = "slide";
  };
  fidget = {
    enable = true;
    progress = {
      display.doneIcon = "✓";
      ignoreDoneAlready = true;
    };
    notification.window.winblend = 0;
  };
}
