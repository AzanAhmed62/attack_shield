// lib/features/organization/presentation/screens/organization_setup_wizard.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/shared/models/plain_language_model.dart';
import 'package:attackshield/shared/providers/plain_language_providers.dart';
import 'package:uuid/uuid.dart';

/// ════════════════════════════════════════════════════════════════════════════════
/// ORGANIZATION SETUP WIZARD
/// 5-step guided flow to create and configure organization profile
/// ════════════════════════════════════════════════════════════════════════════════

class OrganizationSetupWizard extends ConsumerStatefulWidget {
  const OrganizationSetupWizard({super.key});

  @override
  ConsumerState<OrganizationSetupWizard> createState() =>
      _OrganizationSetupWizardState();
}

class _OrganizationSetupWizardState
    extends ConsumerState<OrganizationSetupWizard> {
  late PageController _pageController;
  int currentStep = 0;

  // Step 1: Organization Details
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  BusinessSector? selectedSector;

  // Step 2: Organization Size
  OrganizationSize? selectedSize;

  // Step 3: Technology Stack
  PrimaryTechnology? selectedTechnology;

  // Step 4: Current Defenses
  Set<ExistingDefenses> selectedDefenses = {};

  // Step 5: User Tech Level
  UserTechLevel? selectedTechLevel;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool get _step1Valid =>
      nameController.text.isNotEmpty && selectedSector != null;
  bool get _step2Valid => selectedSize != null;
  bool get _step3Valid => selectedTechnology != null;
  bool get _step4Valid => selectedDefenses.isNotEmpty;
  bool get _step5Valid => selectedTechLevel != null;

  Future<void> _completeSetup() async {
    if (!_step1Valid ||
        !_step2Valid ||
        !_step3Valid ||
        !_step4Valid ||
        !_step5Valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all steps')),
      );
      return;
    }

    try {
      // Calculate baseline risk and prioritized techniques
      final profile = OrganizationProfileV2(
        id: const Uuid().v4(),
        name: nameController.text,
        sector: selectedSector!,
        size: selectedSize!,
        technology: selectedTechnology!,
        currentDefenses: selectedDefenses.toList(),
        userTechLevel: selectedTechLevel!,
        appMode: 'PlainLanguageMode', // Default to plain language for new users
        baselineRiskScore:
            _calculateBaselineRisk(), // Calculated based on sector/size/tech
        prioritizedTechniqueIds:
            [], // Will be populated by threat profile generator
        suggestedCoverageLevels: {}, // Will be populated
        description: descriptionController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save profile
      await ref
          .read(organizationProfileV2Provider.notifier)
          .createOrUpdateProfile(profile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Organization profile created successfully!'),
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  double _calculateBaselineRisk() {
    // Baseline risk calculation
    double risk = 50.0;

    // Sector risk adjustment
    String? sectorKey;
    if (selectedSector != null) {
      final sectorMap = {
        BusinessSector.healthcare: 'healthcare',
        BusinessSector.finance: 'finance',
        BusinessSector.government: 'government',
        BusinessSector.retail: 'retail',
        BusinessSector.manufacturing: 'manufacturing',
        BusinessSector.education: 'education',
        BusinessSector.nonprofit: 'nonprofit',
        BusinessSector.technology: 'technology',
        BusinessSector.hospitality: 'hospitality',
        BusinessSector.other: 'other',
      };
      sectorKey = sectorMap[selectedSector];
    }

    final sectorMultiplier =
        {
          'healthcare': 1.2,
          'finance': 1.3,
          'government': 1.4,
          'retail': 1.1,
          'manufacturing': 0.9,
          'education': 0.9,
          'nonprofit': 0.8,
          'technology': 1.2,
          'hospitality': 0.9,
          'other': 0.7,
        }[sectorKey] ??
        1.0;
    risk *= sectorMultiplier;

    // Size adjustment
    final sizeMultiplier =
        {
          'solo': 0.6,
          'small': 0.8,
          'medium': 1.0,
          'largesmall': 1.2,
          'large': 1.3,
        }[selectedSize?.jsonValue] ??
        1.0;
    risk *= sizeMultiplier;

    // Defense reduction
    double defenseReduction = 1.0;
    if (selectedDefenses.contains(ExistingDefenses.comprehensive)) {
      defenseReduction = 0.4;
    } else if (selectedDefenses.contains(ExistingDefenses.edr)) {
      defenseReduction = 0.5;
    } else if (selectedDefenses.length >= 3) {
      defenseReduction = 0.6;
    } else if (selectedDefenses.isNotEmpty) {
      defenseReduction = 0.8;
    }
    risk *= defenseReduction;

    return risk.clamp(10, 95);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Your Organization'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(value: (currentStep + 1) / 5, minHeight: 4),
          // Step indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(
                5,
                (index) => Expanded(
                  child: Container(
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index <= currentStep
                          ? Colors.blue
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Step content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => currentStep = index);
              },
              children: [
                _buildStep1(), // Organization Details
                _buildStep2(), // Organization Size
                _buildStep3(), // Technology Stack
                _buildStep4(), // Current Defenses
                _buildStep5(), // User Tech Level & Review
              ],
            ),
          ),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentStep > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: const Text('Back'),
                ),
                Text('Step ${currentStep + 1} of 5'),
                ElevatedButton(
                  onPressed: currentStep < 4
                      ? () {
                          final isValid = currentStep == 0
                              ? _step1Valid
                              : currentStep == 1
                              ? _step2Valid
                              : currentStep == 2
                              ? _step3Valid
                              : currentStep == 3
                              ? _step4Valid
                              : _step5Valid;

                          if (isValid) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please complete this step first',
                                ),
                              ),
                            );
                          }
                        }
                      : _completeSetup,
                  child: Text(currentStep < 4 ? 'Next' : 'Complete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Your Organization',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Let\'s start by learning about your organization',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Organization Name',
              hintText: 'e.g., Acme Healthcare Corp',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'e.g., Small dental clinic in California',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'What type of organization?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSectorSelector(),
        ],
      ),
    );
  }

  Widget _buildSectorSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: BusinessSector.values.map((sector) {
        final sectorLabel =
            {
              BusinessSector.healthcare: '🏥 Healthcare',
              BusinessSector.finance: '🏦 Finance',
              BusinessSector.education: '🎓 Education',
              BusinessSector.retail: '🛍️ Retail',
              BusinessSector.manufacturing: '🏭 Manufacturing',
              BusinessSector.government: '🏛️ Government',
              BusinessSector.nonprofit: '💝 Nonprofit',
              BusinessSector.technology: '💻 Technology',
              BusinessSector.hospitality: '🏨 Hospitality',
              BusinessSector.other: '📍 Other',
            }[sector] ??
            sector.name;

        return FilterChip(
          label: Text(sectorLabel),
          selected: selectedSector == sector,
          onSelected: (selected) {
            setState(() => selectedSector = selected ? sector : null);
          },
        );
      }).toList(),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How Many People?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ..._buildSizeOptions(),
        ],
      ),
    );
  }

  List<Widget> _buildSizeOptions() {
    final options = [
      (
        OrganizationSize.solo,
        '👤 Solo (1 person)',
        'Me (freelancer, entrepreneur, individual)',
      ),
      (OrganizationSize.small, '👥 Small (2-10)', 'Small office or startup'),
      (OrganizationSize.medium, '🏢 Medium (11-50)', 'Growing business'),
      (
        OrganizationSize.largeSmall,
        '🏢🏢 Large-Small (51-200)',
        'Established company',
      ),
      (OrganizationSize.large, '🏛️ Large (200+)', 'Enterprise organization'),
    ];

    return options.map((option) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          child: ListTile(
            title: Text(option.$2),
            subtitle: Text(option.$3),
            trailing: Radio<OrganizationSize>(
              value: option.$1,
              groupValue: selectedSize,
              onChanged: (value) {
                setState(() => selectedSize = value);
              },
            ),
            onTap: () {
              setState(() => selectedSize = option.$1);
            },
          ),
        ),
      );
    }).toList();
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What Technology Do You Use?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ..._buildTechnologyOptions(),
        ],
      ),
    );
  }

  List<Widget> _buildTechnologyOptions() {
    final options = [
      (
        PrimaryTechnology.windowsOnly,
        '🪟 Windows Only',
        'Mainly Windows PCs and servers',
      ),
      (PrimaryTechnology.macOnly, '🍎 Mac Only', 'Mainly Apple devices'),
      (PrimaryTechnology.linuxOnly, '🐧 Linux Only', 'Mainly Linux servers'),
      (
        PrimaryTechnology.mixedOnPrem,
        '🖥️ Mixed (On-Premise)',
        'Mix of Windows, Mac, Linux',
      ),
      (
        PrimaryTechnology.cloudPrimary,
        '☁️ Cloud Primary',
        'Mainly Office 365, Google Workspace, AWS',
      ),
      (PrimaryTechnology.hybrid, '🔄 Hybrid', 'Mix of on-premise and cloud'),
    ];

    return options.map((option) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          child: ListTile(
            title: Text(option.$2),
            subtitle: Text(option.$3),
            trailing: Radio<PrimaryTechnology>(
              value: option.$1,
              groupValue: selectedTechnology,
              onChanged: (value) {
                setState(() => selectedTechnology = value);
              },
            ),
            onTap: () {
              setState(() => selectedTechnology = option.$1);
            },
          ),
        ),
      );
    }).toList();
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What Security Do You Have Now?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select all that apply',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ..._buildDefenseOptions(),
        ],
      ),
    );
  }

  List<Widget> _buildDefenseOptions() {
    final options = [
      (ExistingDefenses.nothing, '❌ Nothing Yet', 'No security tools'),
      (ExistingDefenses.basicAv, '🛡️ Antivirus', 'Basic antivirus protection'),
      (
        ExistingDefenses.avAndFirewall,
        '🔥 Antivirus + Firewall',
        'Basic and firewall protection',
      ),
      (ExistingDefenses.mfa, '🔐 MFA', 'Multi-Factor Authentication'),
      (ExistingDefenses.edr, '👁️ EDR', 'Endpoint Detection & Response'),
      (ExistingDefenses.siem, '📊 SIEM', 'Security Information Management'),
      (
        ExistingDefenses.comprehensive,
        '🏆 Comprehensive',
        'Multiple security layers',
      ),
    ];

    return options.map((option) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: CheckboxListTile(
          title: Text(option.$2),
          subtitle: Text(option.$3),
          value: selectedDefenses.contains(option.$1),
          onChanged: (selected) {
            setState(() {
              if (selected == true) {
                selectedDefenses.add(option.$1);
                // Remove 'nothing' if anything else selected
                selectedDefenses.remove(ExistingDefenses.nothing);
              } else {
                selectedDefenses.remove(option.$1);
              }
            });
          },
        ),
      );
    }).toList();
  }

  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Technical Knowledge',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ..._buildTechLevelOptions(),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),
          const Text(
            'Review Your Setup',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildReview(),
        ],
      ),
    );
  }

  List<Widget> _buildTechLevelOptions() {
    return [
      Card(
        child: ListTile(
          title: const Text('👤 Not Technical'),
          subtitle: const Text('I don\'t understand security terms'),
          trailing: Radio<UserTechLevel>(
            value: UserTechLevel.notTechnical,
            groupValue: selectedTechLevel,
            onChanged: (value) {
              setState(() => selectedTechLevel = value);
            },
          ),
          onTap: () {
            setState(() => selectedTechLevel = UserTechLevel.notTechnical);
          },
        ),
      ),
      const SizedBox(height: 12),
      Card(
        child: ListTile(
          title: const Text('💼 Some Technical'),
          subtitle: const Text('I understand basic IT concepts'),
          trailing: Radio<UserTechLevel>(
            value: UserTechLevel.someTechnical,
            groupValue: selectedTechLevel,
            onChanged: (value) {
              setState(() => selectedTechLevel = value);
            },
          ),
          onTap: () {
            setState(() => selectedTechLevel = UserTechLevel.someTechnical);
          },
        ),
      ),
      const SizedBox(height: 12),
      Card(
        child: ListTile(
          title: const Text('🔧 Very Technical'),
          subtitle: const Text('I understand security and IT deeply'),
          trailing: Radio<UserTechLevel>(
            value: UserTechLevel.veryTechnical,
            groupValue: selectedTechLevel,
            onChanged: (value) {
              setState(() => selectedTechLevel = value);
            },
          ),
          onTap: () {
            setState(() => selectedTechLevel = UserTechLevel.veryTechnical);
          },
        ),
      ),
    ];
  }

  Widget _buildReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewItem('Organization', nameController.text),
        _buildReviewItem('Type', selectedSector?.name ?? 'Not selected'),
        _buildReviewItem('Size', selectedSize?.name ?? 'Not selected'),
        _buildReviewItem(
          'Technology',
          selectedTechnology?.name ?? 'Not selected',
        ),
        _buildReviewItem(
          'Defenses',
          selectedDefenses.isEmpty
              ? 'None'
              : selectedDefenses.map((d) => d.name).join(', '),
        ),
        _buildReviewItem(
          'Tech Level',
          selectedTechLevel?.name ?? 'Not selected',
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
