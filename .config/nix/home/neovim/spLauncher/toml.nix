{ ... }: {
  __raw = ''
    if vim.fn.expand("%:t") == "Cargo.toml" then
      ${(import ./rust.nix {}).__raw}
    end
  '';
}
