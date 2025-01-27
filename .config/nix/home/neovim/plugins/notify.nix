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
    lazyLoad.settings.event = ["User FileOpened"];

    settings = {
      progress = {
        display.done_icon = "✓";
        ignore_done_already = true;
      };
      notification.window.winblend = 0;
    };
  };
}
