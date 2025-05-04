{ ... }:
{
  services.beesd.filesystems = {
    System = {
      spec = "LABEL=System";
      hashTableSizeMB = 4096;
      verbosity = "crit";
      workDir = "bees";
      extraOptions = [
        "--thread-count" "6"
        "--loadavg-target" "6"
        "--thread-min" "1"
      ];
    };
  };
}
