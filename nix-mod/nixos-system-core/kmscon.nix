{ pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "Sarasa Term J";
        package = pkgs.sarasa-gothic;
      }
    ];
    hwRender = true;
  };
}
