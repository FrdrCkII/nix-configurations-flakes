{ ... }:
{
  services.beesd.filesystems = {
    System = {
      spec = "/dev/disk/by-uuid/89097e72-acff-475f-8dcd-1931b8665522";
      hashTableSizeMB = 4096;
      verbosity = "crit";
      workDir = "bees";
      extraOptions = [
        "--thread-count"
        "6"
        "--loadavg-target"
        "6"
        "--thread-min"
        "1"
      ];
    };
  };
}
