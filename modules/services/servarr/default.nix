{den, ...}: {
  den.aspects.servarr = {
    includes = with den.aspects; [sonarr radarr prowlarr bazarr];
  };
}
