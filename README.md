# Whisper Transcription Flake

A simple Nix flake that provides Whisper.cpp with a bundled base model for easy speech-to-text transcription.

## Description

This flake packages OpenAI's Whisper (via whisper.cpp) along with the base model, making it easy to transcribe audio files without having to manually download and manage model files.

## Prerequisites

- Nix with flakes enabled

## Usage

To transcribe an audio file:

```bash
nix run .# /path/to/your/audio.wav
```

The audio file should be in WAV format compatible with Whisper.cpp's requirements:
- 16-bit
- 16kHz sample rate
- mono channel

## Features

- Includes whisper.cpp binary
- Automatically downloads and includes the base Whisper model
- Simple CLI interface

## Implementation Details

The flake uses:
- whisper.cpp for efficient CPU-based inference
- Base model (`ggml-base.bin`) from [Hugging Face](https://huggingface.co/ggerganov/whisper.cpp/blob/main/ggml-base.bin)
- Nix for reproducible packaging and deployment

## License

See the LICENSE file for details.