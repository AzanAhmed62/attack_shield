# ATT&CK Defender - Quick Reference Guide

> **⚠️ Status**: Fully Compiled and Functional ✅  
> **Compilation**: 0 errors, 44 info-level warnings (non-blocking)  
> **Latest Build**: April 2, 2026

---

## Quick Start

### Running the App

```bash
# Navigate to project directory
cd /home/aizen/Data/FlutterProjects/attackshield

# Install dependencies
flutter pub get

# Run on Linux desktop
flutter run -d linux

# Or run on web
flutter run -d chrome
```

### Key Commands

```bash
# Code generation (models, providers)
flutter pub run build_runner build --delete-conflicting-outputs

# Static analysis
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test
```

---

## Project Structure at a Glance

```
attackshield/
├── lib/
│   ├── main.dart                          # Entry point
│   ├── app.dart                           # Root widget
│   ├── core/
│   │   ├── theme/       → Material 3 dark theme
│   │   ├── routing/     → GoRouter configuration
│   │   ├── widgets/     → Reusable components
│   │   ├── services/    → LocalStorage wrapper
│   │   ├── errors/      → Exception hierarchy
│   │   ├── utils/       → Helpers & extensions
│   │   └── constants/   → App-wide constants
│   ├── data/
│   │   ├── repositories/  → Technique, Coverage, Bookmark repos
│   │   └── services/      → Data access services
│   ├── shared/
│   │   ├── models/        → 12 Freezed data models
│   │   ├── providers/     → 25+ Riverpod providers
│   │   ├── extensions/    → Shared utilities
│   │   └── helpers/       → Shared functions
│   └── features/
│       ├── dashboard/     → Overview & quick actions
│       ├── attack_library/ → Technique search/browse
│       ├── technique_detail/ → Full technique view
│       ├── threat_mapping/ → Coverage visualization
│       ├── simulations/    → Readiness testing
│       ├── reports/        → Report generation
│       ├── alerts/         → Security intelligence
│       ├── settings/       → App configuration
│       └── onboarding/     → First-time setup
├── DOCUMENTATION.md     ← Complete reference (this directory)
├── README.md           ← Original readme
└── pubspec.yaml        → Dependencies
```

---

## Core Technologies

| Technology | Version | Purpose          |
| ---------- | ------- | ---------------- |
| Flutter    | 3.10.7+ | UI Framework     |
| Dart       | 3.0+    | Language         |
| Riverpod   | 2.4.0+  | State Management |
| Freezed    | 2.4.0+  | Immutable Models |
| GoRouter   | 13.0.0+ | Navigation       |
| GetStorage | 2.1.1+  | Local Storage    |
| FL Chart   | 0.64.0+ | Visualizations   |

---

## Architecture Overview

```
┌─────────────────────────────────────┐
│  Presentation Layer (Screens)       │
│  • Dashboard, Library, Detail, etc. │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  State Management Layer (Riverpod)  │
│  • allTechniquesProvider            │
│  • coveragePercentageProvider       │
│  • filteredTechniquesProvider, etc. │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Domain/Repository Layer            │
│  • AttackTechniqueRepository        │
│  • CoverageRepository               │
│  • BookmarkRepository               │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Data Layer                         │
│  • LocalStorageService (GetStorage) │
│  • Mock data / Future API           │
└─────────────────────────────────────┘
```

---

## Screen Routes

| Route            | File                           | Purpose           |
| ---------------- | ------------------------------ | ----------------- |
| `/`              | `dashboard_screen.dart`        | Home/Overview     |
| `/library`       | `attack_library_screen.dart`   | Technique browser |
| `/technique/:id` | `technique_detail_screen.dart` | Single technique  |
| `/coverage`      | `threat_mapping_screen.dart`   | Coverage view     |
| `/simulations`   | `simulations_screen.dart`      | Test scenarios    |
| `/reports`       | `reports_screen.dart`          | Report generation |
| `/alerts`        | `alerts_screen.dart`           | Security feed     |
| `/settings`      | `settings_screen.dart`         | Configuration     |
| `/onboarding`    | `onboarding_screen.dart`       | First-time setup  |

---

## Data Models

### Core Models (12 Total)

1. **AttackTechnique** - MITRE ATT&CK technique (id, name, tactics, riskScore, etc.)
2. **AttackTactic** - MITRE ATT&CK tactic (TA0001-TA0011, TA0040)
3. **CoverageStatus** - Defensive coverage tracking (level: covered/partial/none)
4. **AlertItem** - Security alert/intelligence (priority, status, timestamp)
5. **SimulationScenario** - Test case definition (objectives, expected outcomes)
6. **SimulationResult** - Test execution result (passed/failed/partial)
7. **BookmarkItem** - Saved technique (with notes)
8. **ReportSummary** - Generated report data (gaps, recommendations)
9. **SecurityAsset** - Organizational asset (OS, criticality)
10. **OrganizationProfile** - App context (personal/lab/organizational)
11. **TechniqueDetection** - Detection method for technique
12. **TechniqueMitigation** - Mitigation strategy for technique

All models use **@freezed** for immutability and JSON serialization.

---

## Key Providers (Riverpod)

### Repository Providers (Singleton)

```dart
localStorageServiceProvider          // GetStorage wrapper
attackTechniqueRepositoryProvider    // Technique CRUD
coverageRepositoryProvider           // Coverage CRUD
bookmarkRepositoryProvider           // Bookmark CRUD
```

### Technique Providers

```dart
allTechniquesProvider                // All techniques
allTacticsProvider                   // All tactics
filteredTechniquesProvider           // Filtered by tactic+search
techniqueByIdProvider(id)            // Single technique
techniquesByTacticProvider(tacticId) // Techniques for tactic
selectedTacticProvider               // Selected tactic filter
searchQueryProvider                  // Search string
```

### Coverage Providers

```dart
allCoverageStatusesProvider          // All coverage records
coveragePercentageProvider           // Overall % covered
coverageBreakdownProvider            // Count by level
techniqueCoverageStatusProvider(id)  // Single technique coverage
```

### Theme Provider

```dart
themeModeProvider                    // Dark/Light toggle
```

---

## Mock Data

### Sample Techniques (5 Included)

| ID    | Name           | Risk | Tactic            |
| ----- | -------------- | ---- | ----------------- |
| T1566 | Phishing       | 8.5  | Initial Access    |
| T1190 | Exploit        | 9.0  | Execution         |
| T1078 | Valid Accounts | 7.5  | Persistence       |
| T1547 | Autostart      | 7.0  | Persistence       |
| T1071 | App Protocol   | 6.5  | Command & Control |

### Sample Tactics (12 Included)

- TA0001: Initial Access
- TA0002: Execution
- TA0003: Persistence
- TA0004: Privilege Escalation
- TA0005: Defense Evasion
- TA0006: Credential Access
- TA0007: Discovery
- TA0008: Lateral Movement
- TA0009: Collection
- TA0010: Exfiltration
- TA0011: Command & Control
- TA0040: Impact

---

## Color Palette

| Element    | Color  | Hex     |
| ---------- | ------ | ------- |
| Primary    | Cyan   | #00D9FF |
| Accent     | Red    | #FF3366 |
| Success    | Green  | #2DCA5E |
| Warning    | Yellow | #FFB800 |
| Error      | Red    | #FF3366 |
| Background | Black  | #000000 |

---

## Common Tasks

### Adding a New Screen

1. Create directory: `lib/features/feature_name/`
2. Create screen: `lib/features/feature_name/presentation/screens/feature_screen.dart`
3. Add route to `lib/core/routing/app_router.dart`
4. Add navigation in relevant screen

### Adding a New Model

1. Create file: `lib/shared/models/my_model.dart`
2. Use `@freezed` annotation with `_$MyModel`
3. Add to `lib/shared/models/models.dart` (export)
4. Run code generation: `flutter pub run build_runner build`

### Adding a New Provider

1. Create/update in `lib/shared/providers/feature_providers.dart`
2. Use `@Riverpod()` annotation
3. Add to `lib/shared/providers/providers.dart` (export)
4. Run code generation: `flutter pub run build_runner build`

### Running Code Generation

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch
```

---

## Debugging Tips

### Check Compilation

```bash
flutter analyze
```

### View Generated Code

```bash
# Models
lib/shared/models/attack_technique.freezed.dart
lib/shared/models/attack_technique.g.dart

# Providers
lib/shared/providers/technique_providers.g.dart
```

### Enable Debug Logging

```dart
// In provider watch calls
final data = ref.watch(allTechniquesProvider);
debugPrint('Techniques: ${data.value?.length}');
```

### Test Specific Widget

```bash
flutter test test/widget_test.dart -k "specific_test_name"
```

---

## Performance Considerations

- **Riverpod caching**: Repository providers use `keepAlive: true` for singleton behavior
- **Lazy loading**: Techniques loaded on-demand, not at app startup
- **Mock data**: Currently in-memory; API integration will add pagination
- **Local storage**: GetStorage for fast key-value access (no encryption)

---

## Future Development Phases

### Phase 2: API Integration

- Connect to remote MITRE ATT&CK data
- Implement pagination and caching
- Add real organization coverage tracking

### Phase 3: Advanced Features

- WebSocket for live alerts
- Multi-user collaboration
- SIEM/MDR integrations
- Compliance report generation

### Phase 4: Mobile Support

- Flutter iOS/Android build
- Responsive mobile UI
- Offline support with sync

---

## Useful Links

- **Documentation**: `DOCUMENTATION.md` (complete reference)
- **Flutter Docs**: https://flutter.dev/docs
- **Riverpod Docs**: https://riverpod.dev
- **MITRE ATT&CK**: https://attack.mitre.org
- **Material 3**: https://m3.material.io

---

## File Locations Quick Reference

| What         | Where                                                         |
| ------------ | ------------------------------------------------------------- |
| Root Widget  | `lib/app.dart`                                                |
| Entry Point  | `lib/main.dart`                                               |
| Theme        | `lib/core/theme/app_theme.dart`                               |
| Routes       | `lib/core/routing/app_router.dart`                            |
| Models       | `lib/shared/models/`                                          |
| Providers    | `lib/shared/providers/`                                       |
| Repositories | `lib/data/repositories/`                                      |
| Screens      | `lib/features/*/presentation/screens/`                        |
| Widgets      | `lib/core/widgets/` or `lib/features/*/presentation/widgets/` |
| Constants    | `lib/core/constants/app_constants.dart`                       |
| Errors       | `lib/core/errors/app_exceptions.dart`                         |
| Utils        | `lib/core/utils/`                                             |

---

## Status Summary

✅ **Project Setup**: Complete  
✅ **Architecture**: Implemented (Clean Architecture + Riverpod)  
✅ **Models**: 12 models with Freezed  
✅ **Repositories**: 3 repositories (Technique, Coverage, Bookmark)  
✅ **Providers**: 25+ providers implemented  
✅ **Screens**: 9 screens with layouts  
✅ **Routing**: GoRouter configured  
✅ **Theme**: Material 3 cybersecurity dark theme  
✅ **Build System**: Code generation working  
✅ **Compilation**: ✨ Clean (0 errors, warnings are deprecation notices)  
✅ **App Launch**: Successful on Linux desktop  
📋 **Next**: API integration and feature completion

---

**For full documentation, see: `DOCUMENTATION.md`**

Last Updated: April 2, 2026
