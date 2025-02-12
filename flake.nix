{
  description = "A flake to use whisper with an appropriate wav, model included";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    whisper-model = system: nixpkgs.legacyPackages.${system}.fetchurl {
      url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin";
      sha256 = "sha256-YO1bw90U7qhWST0zQ0m0BXgt3K8AKNS130CINF+6Lv4=";
    };
  in {
    packages = eachSystem (system: {
      whisper_transcribe = nixpkgs.legacyPackages.${system}.writeShellApplication {
        name = "whisper-transcribe";
        runtimeInputs = [ 
          nixpkgs.legacyPackages.${system}.openai-whisper-cpp 
          (whisper-model system)
        ];
        text = ''
          whisper-cpp -m ${whisper-model system} -f "$1"
        '';
      };

      default = self.packages.${system}.whisper_transcribe;
    });
  };
}