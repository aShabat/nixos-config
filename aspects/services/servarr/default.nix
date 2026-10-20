{
  den,
  aspect-utils,
  ...
}: {
  includes = [den.aspects.services.caddy] ++ aspect-utils.includes-all-subaspects;
}
