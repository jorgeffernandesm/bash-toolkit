# Bash Toolkit

A collection of utility scripts for system administration and media processing.

## Scripts Overview

| Command       | Description |
|--------------|-------------|
| **belfly** | Vocal time notifications at custom intervals (uses `espeak`) |
| **cat** | _(Note: Not included - this is a core Linux command)_ |
| **collect** | Flattens directory structure by moving files to root |
| **cutMedia** | Cuts audio/video files between timestamps (uses `ffmpeg`) |
| **delEXIF** | Strips EXIF metadata from image files |
| **fixBright** | Batch adjusts brightness/contrast of JPG images |
| **fixCamera** | _(Note: Script content not provided)_ |
| **m** | SSHFS mount utility for remote directories |
| **renDirMtime** | Renames directories with their modification date |
| **restartPipeWire** | Restarts PipeWire audio service |
| **sysInfo** | Displays comprehensive system hardware/OS information |

## Requirements

- Core dependencies: `ffmpeg`, `imagemagick`, `sshfs`, `espeak`
- Designed for Linux systems with systemd

## Installation

```bash
git clone https://github.com/yourusername/bash-toolkit.git
cd bash-toolkit
chmod +x ./*