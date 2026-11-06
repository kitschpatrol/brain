# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Eliminate undefined behavior from unsequenced byte-index increments when decoding EEG power values and handling unused raw samples.

### Documentation

- Add a `BrainLogger` Processing example that records timestamped serial EEG readings to `data/brain.csv`.
- Correct `readSignalQuality()` documentation: 0 indicates a good signal and 200 indicates no signal.
- Document headset compatibility, identifying Force Trainer and MindFlex as supported and Force Trainer II and MindWave Mobile 2 as unsupported.
- Fix README heading rendering and typos, and update project links and contact information.

### Maintenance

- Add Arduino library and CodeMeta metadata for library discovery and software cataloging.
- Add GitHub Actions workflows for checking repository and website links and synchronizing repository metadata.

## [1.0.0] - 2014-01-18

### Added

- Introduce an Arduino 1.0 library for reading NeuroSky EEG data from Star Wars Force Trainer and Mattel MindFlex headsets, supporting hardware serial and `SoftwareSerial` through `Brain(Stream&)`.
- Expose signal quality, attention, meditation, and eight EEG power bands through individual accessors and `readPowerArray()`, using fixed-width integer types.
- Provide `update()` for fresh-packet detection, `readCSV()` for CSV output with optional EEG bands, and `readErrors()` for packet-length, checksum, and parsing diagnostics.

### Documentation

- Provide API and CSV-format documentation, headset setup and BrainGrapher links, and Arduino IDE ZIP-import and manual installation instructions.
- Include `BrainBlinker`, `BrainSerialTest`, and `BrainSoftSerialTest` examples demonstrating attention-controlled LED blinking, hardware serial CSV output, and software serial input.

### Maintenance

- Set up Arduino library packaging and IDE syntax highlighting, with LGPL-3.0-or-later licensing.

[Unreleased]: https://github.com/kitschpatrol/brain/compare/v1.0...HEAD
[1.0.0]: https://github.com/kitschpatrol/brain/releases/tag/v1.0
