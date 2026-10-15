{
  config,
  lib,
  ...
}: {
  options.utils = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = {};
  };

  config._module.args.utils = config.utils or {};
}
