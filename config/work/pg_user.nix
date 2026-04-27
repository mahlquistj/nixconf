{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "pg_user";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "frederikhs";
    repo = "pg_user";
    rev = "v${version}";
    hash = "sha256-J3ZWaHF7VqgJg/8G8Ul8pP1on3xjcMs43ti+1XGO1NQ=";
  };

  vendorHash = "sha256-CY/kSNBqHGykQNbXFobMM+qFPvNAk3NxVCbqlBJLAOE=";

  meta = {
    description = "A cli application for managing postgres users using .pgpass";
    homepage = "https://github.com/frederikhs/pg_user";
    license = lib.licenses.gpl3;
  };
}
