{
  lib,
  cfg,
  ...
}:
{
  users = {
    groups = {
      nixwheel = { };
    };
    users = lib.foldl (
      acc: user:
      {
        ${user.name} = {
          isNormalUser = true;
          name = user.name;
          home = lib.mkIf (user.home != null) user.home;
          extraGroups = lib.mkIf (user.groups != null) user.groups;
          hashedPassword = lib.mkIf (user.passwd != null) user.passwd;
          shell = lib.mkIf (user.shell != null) user.shell;
        };
      }
      // acc
    ) { } cfg.hom;
  };
}
