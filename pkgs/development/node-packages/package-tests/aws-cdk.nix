{ lib, runCommand, aws-cdk }:

let
  inherit (aws-cdk) packageName version;
  cdk = lib.getExe aws-cdk;
in
runCommand "${packageName}-tests" { meta.timeout = 60; } ''
  set -e
  mkdir $out
  cd $out

  claimed_version="$(${cdk} --version | grep -o -E '^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+')"

  if [[ "$claimed_version" != "${version}" ]]; then
    echo "Error: program version does not match package version ($claimed_version != ${version})"
    exit 1
  fi

  # Ensure CLI runs
  ${cdk} --help >/dev/null

  # Test Each language init
  languages=(
    'csharp'
    'fsharp'
    'go'
    'java'
    'javascript'
    'python'
    'typescript'
  )

  for lang in $languages; do
    mkdir "$lang"

    pushd "$lang"
    ${cdk} init --language "$lang"
    popd
  done
''
