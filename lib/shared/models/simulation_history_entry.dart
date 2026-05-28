// lib/features/simulations/presentation/models/simulation_history_entry.dart
// NEW FILE — extracted from simulations_screen.dart so it can be imported
// by both simulation_providers.dart and simulations_screen.dart.

class SimulationHistoryEntry {
  final String   scenarioName;
  final String   scenarioIcon;
  final int      totalTechniques;
  final double   readiness;
  final DateTime timestamp;

  const SimulationHistoryEntry({
    required this.scenarioName,
    required this.scenarioIcon,
    required this.totalTechniques,
    required this.readiness,
    required this.timestamp,
  });
}
