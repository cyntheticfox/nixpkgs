{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-lambda";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "cargo-lambda";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-KJKpIszBrLK2GaKMxF00YngAEgyut7QuHo+kToqc+w4=";
  };

  cargoHash = "sha256-/HwerFfh5K/rkkMNPRWy24XBq3b/Jp4GTm9g1Le1PdY=";

  buildAndTestSubdir = "crates/cargo-lambda-cli";

  # Some tests fail because they need network access.
  doCheck = false;

  meta = with lib; {
    description = "A Cargo subcommand to help work with AWS Lambda.";
    homepage = "https://github.com/cargo-lambda/cargo-lambda";
    license = licenses.mit;
    maintainers = with maintainers; [ houstdav000 ];
  };
}
