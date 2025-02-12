{
  description = "A flake to use whisper with an appropriate wav, model included";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let 
    whisper-model = nixpkgs.legacyPackages.aarch64-darwin.fetchurl {
      url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin";
      sha256 = "sha256-YO1bw90U7qhWST0zQ0m0BXgt3K8AKNS130CINF+6Lv4=";
    };
  in {
    # Takes a wav file and returns a string
    packages.aarch64-darwin.whisper_transcribe = nixpkgs.legacyPackages.aarch64-darwin.writeShellApplication {
    	name = "whisper-transcribe";
	runtimeInputs = [ nixpkgs.legacyPackages.aarch64-darwin.openai-whisper-cpp whisper-model ];
	text = ''
	  whisper-cpp -m ${whisper-model} -f "$1"
	'';
    };

    packages.aarch64-darwin.default = self.packages.aarch64-darwin.whisper_transcribe;

  };
}
