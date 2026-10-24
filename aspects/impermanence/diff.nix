{
  nixos = {
    lib,
    config,
    pkgs,
    ...
  }: let
    snapshot-script-name = "impermanence-snapshot";
    snapshot-text = ''
      snapshot=/persistent/.impermanence-snapshot
      tmp=$(mktemp "$snapshot.XXXXXX")

      if find / -xdev -type f -print0 | LC_ALL=C sort -z > "$tmp"
      then
        mv -f "$tmp" "$snapshot"
      else
        rm -f "$tmp"
        echo "impermanence snapshot failed" >&2
    '';
    snapshot-script = {
      deps =
        lib.subtractLists [snapshot-script-name "script"]
        (lib.attrNames config.system.activationScripts);
      text = snapshot-text;
    };
    diff-text = ''
      snapshot=/persistent/.impermanence-snapshot

      find / -xdev -type f -print0 | comm -z -13 "$snapshot" - | tr '\0' '\n'
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
}
