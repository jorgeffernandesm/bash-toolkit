[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.com/donate/?hosted_button_id=Q6ZB8NDZXTDTS)
<a href="https://www.paypal.com/donate/?hosted_button_id=Q6ZB8NDZXTDTS" target="_blank">
  <img src="https://www.paypalobjects.com/webstatic/icon/pp258.png" height="20" alt="Donate with PayPal">
</a>

# Bash Toolkit

A collection of utility scripts for Ubuntu system administration and media processing.

## Scripts Overview

### System Utilities
| Command       | Description |
|--------------|-------------|
| **belfly** | Vocal time notifications at custom intervals (uses `espeak`) |
| **collect** | Flattens directory structure by moving files to root |
| **m** | SSHFS mount utility for remote directories |
| **renDirMtime** | Renames directories with their modification date |
| **restartPipeWire** | Restarts PipeWire audio service |
| **sysInfo** | Displays comprehensive system hardware/OS information |
| **radar** | Creates desktop symlinks to frequently accessed files |

### Media Processing
| Command       | Description |
|--------------|-------------|
| **bw** | Converts images to black-and-white |
| **cutMedia** | Cuts audio/video files between timestamps (uses `ffmpeg`) |
| **delEXIF** | Strips EXIF metadata from image files |
| **fixBright** | Batch adjusts brightness/contrast of JPG images |
| **greyscale** | Converts images to grayscale with auto-gamma correction |
| **catSounds** | Plays random MP3s at configurable intervals (ideal for cats) |

### Conversion Tools
| Command       | Description |
|--------------|-------------|
| **conv** | Converts between audio/video formats (mp3, opus, etc.) |
| **img2pdf** | Converts images to PDF while preserving full image content |
| **pdf2jpg** | Converts PDF pages to individual JPG files |
| **pdf2png** | Converts PDF files to high-quality PNG format |

## Requirements

- Core dependencies: `ffmpeg`, `imagemagick`, `sshfs`, `espeak`, `mpg123`, `poppler-utils`
- Designed for Linux systems with systemd

## Installation

```bash
git clone https://github.com/yourusername/bash-toolkit.git
cd bash-toolkit
chmod +x ./*

# Optional: Add to PATH
sudo ln -s $(pwd)/* /usr/local/bin/
```

<img src="https://omicronyx.com/images/jorgeLogo.png" width="20"/> Jorge Fernandes

[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.com/donate/?hosted_button_id=Q6ZB8NDZXTDTS)
<a href="https://www.paypal.com/donate/?hosted_button_id=Q6ZB8NDZXTDTS" target="_blank">
  <img src="https://www.paypalobjects.com/webstatic/icon/pp258.png" height="20" alt="Donate with PayPal">
</a>