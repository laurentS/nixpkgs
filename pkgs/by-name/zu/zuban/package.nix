{
  fetchFromGitHub,
  lib,
  rustPlatform,
  versionCheckHook,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zuban";

  version = "0.0.22";

  src = fetchFromGitHub {
    owner = "zubanls";
    repo = "zuban";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gEABkRHp6idNrIQoA9x0Ak4e+WiRMmY/kTr77v3byrg=";
  };

  buildAndTestSubdir = "crates/zuban";

  cargoHash = "sha256-+sir/906kzH/Xc2+MnGXQPayIlowfR8nlXM+QNLI6IA=";

  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  versionCheckProgramArg = "--version";
  doInstallCheck = true;

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Mypy-compatible Python Language Server built in Rust";
    homepage = "https://zubanls.com";
    changelog = "https://docs.zubanls.com/en/latest/changelog.html";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [
      mcjocobe
    ];
    platforms = lib.platforms.all;
    mainProgram = "zuban";
  };
})
