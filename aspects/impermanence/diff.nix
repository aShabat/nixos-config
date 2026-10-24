{
  nixos = {
    lib,
    config,
    pkgs,
    ...
  }: let
    snapshot-file = "/persistent/.impermanence-snapshot";
    snapshot-script-name = "impermanence-snapshot";
    snapshot-text = ''
      snapshot=${snapshot-file}
      tmp=$(mktemp "$snapshot.XXXXXX")

      if find / -xdev \
      \( -path /home -o -path /var/cache -o -path /var/tmp -o -path /tmp \) -prune -o \
      -type f -print0 |
      LC_ALL=C sort -z > "$tmp"
      then
        mv -f "$tmp" "$snapshot"
      else
        rm -f "$tmp"
        echo "impermanence snapshot failed" >&2
      fi
    '';
    snapshot-script = {
      deps =
        lib.subtractLists [snapshot-script-name "script"]
        (lib.attrNames config.system.activationScripts);
      text = snapshot-text;
    };
    diff-text = ''
      snapshot=${snapshot-file}

      find / -xdev \
      \( -path /home -o -path /var/cache -o -path /var/tmp -o -path /tmp \) -prune -o \
      -type f -print0 |
      LC_ALL=C sort -z |
      LC_ALL=C comm -z -13 "$snapshot" - |
      tr '\0' '\n'
    '';
    diff-script = pkgs.writeShellApplication {
      name = "impermanence-diff";
      text = diff-text;
      runtimeInputs = with pkgs; [findutils coreutils];
    };
  in {
    system.activationScripts.${snapshot-script-name} = snapshot-script;
    environment.systemPackages = [diff-script];
  };

  homeManager = {
    lib,
    config,
    pkgs,
    ...
  }: let
    snapshot-file = "/persistent${config.home.homeDirectory}/.impermanence-home-snapshot";
    snapshot-script-name = "impermanence-home-snapshot";
    snapshot-text = ''
      snapshot=${snapshot-file}
      tmp=$(mktemp "$snapshot.XXXXXX")

      if find "$HOME" -xdev \
      \( \
        -path "$HOME/.cache" \
        -o -path "$HOME/.local/share/man" \
        -o -path "$HOME/.local/share/fish/generated_completions" \
      \) -prune -o \
      -type f -print0 |
      LC_ALL=C sort -z > "$tmp"
      then
        mv -f "$tmp" "$snapshot"
      else
        rm -f "$tmp"
        echo "impermanence snapshot failed" >&2
      fi
    '';
    snapshot-script = pkgs.writeShellApplication {
      name = snapshot-script-name;
      runtimeInputs = with pkgs; [findutils coreutils];
      text = snapshot-text;
    };
    diff-text = ''
      snapshot=${snapshot-file}

      find "$HOME" -xdev \
      \( \
        -path "$HOME/.cache" \
        -o -path "$HOME/.local/share/man" \
        -o -path "$HOME/.local/share/fish/generated_completions" \
      \) -prune -o \
      -type f -print0 |
      LC_ALL=C sort -z |
      LC_ALL=C comm -z -13 "$snapshot" - |
      tr '\0' '\n'
    '';
    diff-script = pkgs.writeShellApplication {
      name = "impermanence-home-diff";
      text = diff-text;
      runtimeInputs = with pkgs; [findutils coreutils];
    };
  in {
    home.activation.${snapshot-script-name} =
      config.lib.dag.entryAfter (lib.subtractLists [snapshot-script-name] (lib.attrNames config.home.activation))
      "${snapshot-script}/bin/${snapshot-script-name}";

    home.packages = [diff-script];
  };
}
