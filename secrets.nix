let
  hosts = [
    "nixos"
  ];

  users = [
    "thein3rovert_nixos"
    "thein3rovert_wellsjaha"
    "thein3rovert_bellamy"
    "thein3rovert_lexa"
    "thein3rovert_finn"
  ];

  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in
{
  "secret1.age".publicKeys = keys;
  "./minioS3/minioS3.age".publicKeys = keys;
  # Initial solution for root enviroment variable (Terraform)
  "./minioS3/minioS3_id.age".publicKeys = keys;
  "./minioS3/minioS3_secret.age".publicKeys = keys;

  # Keys from here will have nixos and wellsjaha
  "./linkding/linkding.age".publicKeys = keys;
  "./freshrss/freshrss.age".publicKeys = keys;
  "./tailscale/tailscale-auth.age".publicKeys = keys;
  "./audiobookshelf/audiobookshelf-ts.age".publicKeys = keys;
  "./godaddy/godaddy.age".publicKeys = keys;
  "./glance/glance.age".publicKeys = keys;
  "./ragenix/tagenixTest.age".publicKeys = keys;
  "./n8n/n8n.age".publicKeys = keys;
  "./aws/accessKey/thein3rovert.age".publicKeys = keys;
  "./aws/accessSecret/thein3rovert_secret.age".publicKeys = keys;
  "./garage/admin_token.age".publicKeys = keys;
  "./garage/rpc_secret.age".publicKeys = keys;
  "./garage/garage-env.age".publicKeys = keys;
}
