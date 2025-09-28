let
  hosts = [
    "nixos"
  ];

  users = [ "thein3rovert_nixos" ];

  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in
{
  "secret1.age".publicKeys = keys;
  "./minioS3/minioS3.age".publicKeys = keys;
}
