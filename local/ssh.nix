{ ... }: {
  programs.ssh = {
    enable = true;
    compression = true;
    serverAliveInterval = 60;
    serverAliveCountMax = 2;
    hashKnownHosts = true;
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
    matchBlocks = {
      milch = {
        hostname = "milch.schokokeks.org";
        user = "lars";
        forwardAgent = true;
      };
      dodecaphonism = {
        hostname = "dodecaphonism.local";
        user = "lstrojny";
        forwardAgent = true;
      };
      heap = {
        hostname = "heap.local";
        user = "root";
        forwardAgent = true;
      };
      most = {
        hostname = "most.local";
        user = "lstrojny";
        forwardAgent = true;
      };
      akj-prod = {
        hostname = "zucker.schokokeks.org";
        user = "akjumii";
        forwardAgent = true;
      };
      in-staff = {
        hostname = "staff.internations.org";
        user = "root";
        forwardAgent = true;
      };
    };
  };
}
