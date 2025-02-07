# My nixos configuration/dotfiles

> [!WARNING]
> 
> Feel free to use this however you like. Issues can be opened, but don't expect immediate help, as this is **intended for my own usage**.
>
> Breaking changes may occur at any time.
>

## Usage

1. Fork the repo.
2. Change options such as username and styling to your likin.
3. Use `nixos-rebuild --flake .#<hostname> --impure` to build

I use `--impure` in my configurations because i haven't found a good enough way to handle
encrypted drives when re-installing. The flake pulls from `/etc/nixos/configuration.nix` and 
`/etc/nixos/hardware-configuration.nix` so be sure that these exist.

The flake will point out if any options set in your `/etc/nixos/configuration.nix` should 
conflict with the flakes' configuration.




## Inspiration & honorable mentions

Initial file-structure inspiration: https://github.com/namishh/crystal/tree/main