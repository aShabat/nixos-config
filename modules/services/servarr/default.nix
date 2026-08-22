{den, ...}: {
  den.aspects.servarr = {
    include = with den.aspects; [sonarr radarr prowlarr bazarr];
  };
}
