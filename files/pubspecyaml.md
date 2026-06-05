name: attackshield
description: "ATT&CK Shield — MITRE ATT&CK defensive cybersecurity platform"
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ^3.10.7

dependencies:
  flutter:
    sdk: flutter

  # Network
  http: ^1.2.0

  # Core
  cupertino_icons: ^1.0.8

  # State Management
  riverpod: ^2.4.0
  hooks_riverpod: ^2.4.0
  flutter_hooks: ^0.20.0        # ADDED — required for HookConsumerWidget
  riverpod_annotation: ^2.3.0

  # Serialization
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0

  # Local Storage
  get_storage: ^2.1.1

  # UI & Charts
  fl_chart: ^0.64.0

  # Utilities
  intl: ^0.19.0
  share_plus: ^7.2.0
  logger: ^2.0.0
  timeago: ^3.6.0
  uuid: ^4.0.0
  google_fonts: ^8.0.2
  float_column: ^4.0.3

  # Navigation
  go_router: ^13.0.0

  # PDF Export
  pdf: ^3.10.0
  printing: ^5.11.0

  # URL Launcher                  # ADDED — required by technique_detail_screen
  url_launcher: ^6.2.0

  # Package Info                  # ADDED — required by settings_screen
  package_info_plus: ^5.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0

flutter:
  uses-material-design: true
  assets:
    - assets/data/enterprise-attack-14.5.json
    - assets/data/plain_language_mappings.json
