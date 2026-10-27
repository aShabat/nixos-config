# Warden migration TODO

New host `warden` (AMD desktop), Niri + Noctalia, dev toolchains via devenv.
`archer` and `hierophant` stay unchanged.

## Decisions

- Desktop: Niri + Noctalia (no Plasma, no SDDM; keep greetd/tuigreet).
- Global packages: GUI apps + daily CLI only. Toolchains belong in per-project devenv.
- Hebrew keyboard layout: optional, one line in niri config.

## Phase 0 — bootstrap

- [ ] Back up Arch `$HOME` and the git-crypt key (eval fails without it: `github-token.secret`, `anton.secret`).
- [ ] Partition: ESP >=1G, btrfs labelled `nixos`, subvols `root`/`nix`/`persistent` (zram or swapfile; Arch's `@`/snapper layout is not reusable).
- [ ] Minimal NixOS install, clone repo to `/etc/nixos`, `git-crypt unlock`.
- [ ] `aspects/warden.nix`: raw `users.users.anton-tmp` (`isNormalUser`, `wheel`, `shell = pkgs.fish`, `initialPassword`) — NOT a Den user, to avoid the `user-password`/`hashedPasswordFile` conflict.
- [ ] Paste `nixos-generate-config --show-hardware-config` output into `aspects/warden.nix`, fill UUIDs.
- [ ] First boot as `anton-tmp` -> `run0 nixos-rebuild switch --flake /etc/nixos#warden` -> verify `anton` login -> drop `anton-tmp` + `nix-collect-garbage -d`.
- [ ] Note: `initialPassword` is plaintext in `/nix/store` and git; use a throwaway, or `initialHashedPassword` if preferred.
- [ ] Note: `ssh` sets `AllowUsers` to the primary user only, so `anton-tmp` has no SSH access unless added explicitly.

## Phase 1 — host registration

- [ ] `modules/hosts.nix`: `den.hosts.x86_64-linux.warden.users.anton = {};`
- [ ] `aspects/warden.nix`: `includes = [den.aspects.desktop den.aspects.steam]`; AMD microcode, `kvm-amd`, `initrd.availableKernelModules`, fileSystems, `hardware.enableRedistributableFirmware`.

## Phase 2 — desktop plumbing (new aspects)

- [ ] `desktop/audio.nix`: pipewire (alsa, 32-bit, pulse), `security.rtkit`, easyeffects (RNNoise; `noise-suppression-for-voice` is gone from nixpkgs).
- [ ] `desktop/bluetooth.nix`: `hardware.bluetooth`, powerOnBoot, persist `/var/lib/bluetooth`.
- [ ] `desktop/fonts.nix`: `fonts.fontDir.enable` (Steam/Electron), noto + CJK + emoji, nerd-fonts, adwaita, liberation, unifont, victor-mono; fontconfig defaults.
- [ ] `desktop/portals.nix`: `xdg.portal.enable`, `xdgOpenUsePortal`, gtk + gnome portals (test screen sharing before choosing).
- [ ] `desktop/polkit.nix`: `security.polkit.enable` + spawn agent from niri.
- [ ] `desktop/session.nix`: terminal (`ghostty` or `kitty`), `fuzzel`, `swaylock`/Noctalia lock, `swayidle`, `playerctl`, `wl-clipboard`, `cliphist`, `brightnessctl`, `xwayland-satellite`.
- [ ] `desktop/theming.nix`: `programs.dconf.enable`, GTK theme/icons/cursors (adwaita, bibata), Qt platform theme; matugen/Noctalia owns colours.
- [ ] `desktop/wayland-env.nix`: `NIXOS_OZONE_WL`, `MOZ_ENABLE_WAYLAND`, `QT_QPA_PLATFORM`, `programs.nix-ld.enable`.
- [ ] `hardware/amd-gpu.nix`: `hardware.graphics.{enable,enable32Bit,extraPackages}` (mesa, vulkan-radeon, libva-utils, rocmPackages.clr, ocl-icd), `hardware.i2c.enable`, `services.fwupd`, optional `amdgpu.ppfeaturemask`.
- [ ] `hardware/power.nix`: `upower`, `power-profiles-daemon`, `earlyoom`, `lm_sensors`; fan curve via `fan2go`/`nbfc-linux` (no `amdgpu-fan`) or skip.
- [ ] `hardware/printing.nix`: `services.printing` + drivers, avahi + nssmdns4, `hardware.sane`, `system-config-printer`; verify Xerox Phaser 3020 (no nixpkgs driver — try splix/IPP).
- [ ] `hardware/peripherals.nix`: `udisks2`, `gvfs`, `devmon`, `usbmuxd`, `pcscd`, `bolt`, `programs.adb.enable` + android-udev-rules, `libwacom` (wacomtablet removed upstream).

## Phase 3 — apps + persistence

- [ ] `apps/browsers.nix`: firefox-devedition, chromium, google-chrome — persist `.mozilla`, `.config/{chromium,google-chrome}`.
- [ ] `apps/comms.nix`: vesktop, slack, telegram-desktop, zoom, zapzap — persist their `.config`/`.local/share` dirs.
- [ ] `apps/media.nix`: mpv + uosc/thumbfast/shaders, vlc, obs-studio + wlrobs, spotify, gimp, calibre, handbrake, jellyfin-mpv-shim.
- [ ] `apps/office.nix`: libreoffice-still, obsidian, poppler-utils, qpdf, tesseract, ghostscript.
- [ ] `apps/dev.nix`: code, gvim, yazi, starship, matugen, btop, dust, ripgrep-all, ncdu, jq, difftastic, just.
- [ ] `apps/vms.nix`: qemu_full, virt-manager + libvirtd (kvm/libvirtd groups, virtiofsd, swtpm), docker, distrobox, flatpak, android-file-transfer — persist `/var/lib/{libvirt,docker,flatpak}`.
- [ ] `apps/kde.nix` (optional): only used apps — dolphin, ark, kate, kcalc, spectacle, filelight, kclock, kweather, keysmith, isoimagewriter, print-manager.
- [ ] `services/syncthing.nix`, `services/dropbox.nix` (or maestral) + persistence.

## Phase 4 — fixes shared with archer

- [ ] Niri `Mod+T` spawns uninstalled `alacritty`; install a terminal or rebind. `Mod+D` fuzzel likewise.
- [ ] Spawn a polkit agent next to `noctalia` in `config.kdl`.
- [ ] Neovim enables lua_ls/fish_lsp/nixd but ships no binaries: add `-- nixpkgs:lua-language-server`, `-- nixpkgs:fish-lsp`, `-- nixpkgs:nixd` comments.
- [ ] `aspects/keyring.nix`: `security.pam.services.greetd.enableGnomeKeyring = true`.
- [ ] Fill `aspects/desktop/niri/noctalia/` (currently empty; it symlinks into the repo, so settings changes are commit-able).

## Phase 5 — verification

- [ ] `nix flake check --no-build --no-write-lock-file`
- [ ] `nix build .#nixosConfigurations.warden.config.system.build.toplevel`
- [ ] Boot test: audio, BT, fonts in Electron apps, file picker, screenshot, screen share, Steam, printer.

## Risks

- Xerox Phaser 3020 driver.
- GPU fan curve (no `amdgpu-fan`).
- Discord/vesktop screen sharing on Wayland.
- `run0` instead of sudo breaks sudo-assuming scripts.
- Dropbox self-updating daemon on immutable root.
