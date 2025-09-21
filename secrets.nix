let
  # Root public keys
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEimTrJGM5TmMDM32+F9a7OxKqvlbGOxGey7XveDYv1S";

  # Home public ssh-keys
  introvert = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHslvxbDHisZaTqmsly3ZfSERVOfoEN4qPcVzIzmvIK";

  systems = [
    nixos
  ];

  users = [
    introvert
  ];
in
{
  "secret1.age".publicKeys = systems ++ users;
  "minioS3.age".publicKeys = systems ++ users;
}
