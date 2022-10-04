{ fetchFromGitHub
, lib
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "what";
  version = "5.1.0";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "bee-san";
    repo = "pywhat";
    rev = version;
    hash = "sha256-z7/ySNq+0eP2i21UpJ1sIuzYgEp2dIANh2bwunjTeZI=";
  };

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
  ];

  checkInputs = with python3.pkgs; [
    cloudpickle
    coverage
    hypothesis
    mypy
    pympler
    pytest
    pytest-mypy-plugins
    six
    zope_interface
  ];

  meta = with lib; {
    homepage = "https://github.com/bee-san/pywhat";
    description = "A tool for identifying what text is meant to be";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "what";
    maintainers = [ maintainers.houstdav000 ];
  };
}
