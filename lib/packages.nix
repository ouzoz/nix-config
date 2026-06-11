{ mapNixFiles, ... }:
{
  packagesFrom = pkgs: path: mapNixFiles (_name: file: pkgs.callPackage file { }) path;
}
