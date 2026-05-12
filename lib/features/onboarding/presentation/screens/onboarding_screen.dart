import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/services/seed_data_service.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/shared/providers/plain_language_providers.dart';
import 'package:attackshield/core/constants/constants.dart';
import 'package:attackshield/data/repositories/repositories.dart';
import 'package:attackshield/data/services/services.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  // Step 3 — Use case
  String? _useCase; // 'personal' | 'lab' | 'organization'

  // Step 4 — Sector & size
  OrgSector _sector = OrgSector.sme;
  OrgSize _orgSize = OrgSize.small;

  // Step 5 — Tech stack & controls
  final Set<TechStackItem> _techStack = {};
  final Set<SecurityControl> _controls = {};

  static const int _totalPages = 5;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageCtrl.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _back() {
    if (_currentPage > 0) {
      _pageCtrl.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  bool get _canProceed {
    switch (_currentPage) {
      case 2:
        return _useCase != null;
      case 3:
        return true; // sector always has a default
      case 4:
        return _techStack.isNotEmpty;
      default:
        return true;
    }
  }

  Future<void> _complete() async {
    if (_useCase == null) return;
    setState(() => _isLoading = true);

    try {
      // Build org profile using V2 model for dashboard compatibility
      final orgName = switch (_useCase) {
        'personal' => 'Personal Learning',
        'lab' => 'Lab Environment',
        _ => 'My Organization',
      };

      // Map OrgSector to BusinessSector (similar enum structure)
      final businessSector = switch (_sector) {
        OrgSector.healthcare => BusinessSector.healthcare,
        OrgSector.finance => BusinessSector.finance,
        OrgSector.education => BusinessSector.education,
        OrgSector.retail => BusinessSector.retail,
        OrgSector.government => BusinessSector.government,
        OrgSector.technology => BusinessSector.technology,
        OrgSector.manufacturing => BusinessSector.manufacturing,
        OrgSector.energy => BusinessSector.nonprofit,
        OrgSector.sme => BusinessSector.nonprofit,
        OrgSector.personal => BusinessSector.other,
        OrgSector.other => BusinessSector.other,
      };

      // Map OrgSize to OrganizationSize (similar enum structure)
      final organizationSize = switch (_orgSize) {
        OrgSize.micro => OrganizationSize.solo,
        OrgSize.small => OrganizationSize.small,
        OrgSize.medium => OrganizationSize.medium,
        OrgSize.large => OrganizationSize.largeSmall,
        OrgSize.enterprise => OrganizationSize.large,
      };

      // Convert TechStackItem to PrimaryTechnology enum
      final techValue = _techStack.isEmpty
          ? PrimaryTechnology.hybrid
          : _techStack.contains(TechStackItem.windows) &&
                _techStack.contains(TechStackItem.linux)
          ? PrimaryTechnology.hybrid
          : _techStack.contains(TechStackItem.windows)
          ? PrimaryTechnology.windowsOnly
          : _techStack.contains(TechStackItem.linux)
          ? PrimaryTechnology.linuxOnly
          : PrimaryTechnology.hybrid;

      // Convert SecurityControl to ExistingDefenses enum
      final defenses =
          _controls.isEmpty || _controls.contains(SecurityControl.none)
          ? <ExistingDefenses>[]
          : _controls
                .where((c) => c != SecurityControl.none)
                .map((c) {
                  switch (c) {
                    case SecurityControl.antivirus:
                    case SecurityControl.firewall:
                      return ExistingDefenses.avAndFirewall;
                    case SecurityControl.emailFiltering:
                    case SecurityControl.siem:
                      return ExistingDefenses.siem;
                    case SecurityControl.edr:
                      return ExistingDefenses.edr;
                    case SecurityControl.mfa:
                      return ExistingDefenses.mfa;
                    default:
                      return null;
                  }
                })
                .whereType<ExistingDefenses>()
                .toSet()
                .toList();

      final profile = OrganizationProfileV2(
        id: const Uuid().v4(),
        name: orgName,
        sector: businessSector,
        size: organizationSize,
        technology: techValue,
        currentDefenses: defenses.isEmpty ? [ExistingDefenses.mfa] : defenses,
        userTechLevel: UserTechLevel.notTechnical,
        appMode: 'PlainLanguageMode',
        baselineRiskScore: 50.0,
        prioritizedTechniqueIds: [],
        suggestedCoverageLevels: {},
        description: 'Organization profile created via onboarding',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save V2 profile using the StateNotifier (saves to 'org_profile_v2' key)
      await ref
          .read(organizationProfileV2Provider.notifier)
          .createOrUpdateProfile(profile);

      // Mark onboarding complete
      await GetStorage().write(AppConstants.storageKeyOnboardingComplete, true);

      // Seed initial content immediately so the first post-onboarding session
      // renders the same data users would see after a restart.
      final storageService = LocalStorageService();
      await storageService.initialize();
      final seedService = SeedDataService(
        storage: storageService,
        alertRepo: AlertRepositoryImpl(storageService),
        simRepo: SimulationRepositoryImpl(storageService),
        assetRepo: AssetRepositoryImpl(storageService),
      );
      await seedService.seedIfNeeded();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile created! Initializing dashboard…'),
            backgroundColor: AppTheme.successColor,
            duration: Duration(seconds: 2),
          ),
        );
        context.go('/');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Setup failed: $e'),
            backgroundColor: AppTheme.dangerColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Progress bar ─────────────────────────────────────────
            _ProgressBar(current: _currentPage, total: _totalPages),

            // ── Pages ────────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _WelcomePage(),
                  _AttackExplainerPage(),
                  _UseCasePage(
                    selected: _useCase,
                    onSelected: (uc) => setState(() => _useCase = uc),
                  ),
                  _SectorSizePage(
                    sector: _sector,
                    orgSize: _orgSize,
                    onSectorChanged: (s) => setState(() => _sector = s),
                    onSizeChanged: (s) => setState(() => _orgSize = s),
                  ),
                  _TechControlsPage(
                    selectedTech: _techStack,
                    selectedControls: _controls,
                    onTechToggled: (t) => setState(() {
                      if (_techStack.contains(t)) {
                        _techStack.remove(t);
                      } else {
                        _techStack.add(t);
                      }
                    }),
                    onControlToggled: (c) => setState(() {
                      if (c == SecurityControl.none) {
                        _controls.clear();
                        _controls.add(SecurityControl.none);
                      } else {
                        _controls.remove(SecurityControl.none);
                        if (_controls.contains(c)) {
                          _controls.remove(c);
                        } else {
                          _controls.add(c);
                        }
                      }
                    }),
                  ),
                ],
              ),
            ),

            // ── Bottom navigation ─────────────────────────────────────
            _BottomNav(
              currentPage: _currentPage,
              totalPages: _totalPages,
              canProceed: _canProceed,
              isLoading: _isLoading,
              onBack: _back,
              onNext: _next,
              onComplete: _complete,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Progress bar ─────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    final labels = ['Welcome', 'ATT&CK', 'Use Case', 'Profile', 'Technology'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
            children: List.generate(total, (i) {
              final isActive = i <= current;
              final isCurrent = i == current;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
                  height: isCurrent ? 5 : 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppTheme.primaryColor
                        : AppTheme.primaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labels[current],
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Step ${current + 1} of $total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Bottom nav ───────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool canProceed;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onComplete;

  const _BottomNav({
    required this.currentPage,
    required this.totalPages,
    required this.canProceed,
    required this.isLoading,
    required this.onBack,
    required this.onNext,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (currentPage > 0)
            OutlinedButton(onPressed: onBack, child: const Text('Back'))
          else
            const SizedBox(width: 80),
          const Spacer(),
          // Dot indicators
          Row(
            children: List.generate(totalPages, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: currentPage == i ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: currentPage == i
                      ? AppTheme.primaryColor
                      : AppTheme.primaryColor.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const Spacer(),
          if (currentPage < totalPages - 1)
            ElevatedButton(
              onPressed: canProceed ? onNext : null,
              child: const Text('Next  →'),
            )
          else
            ElevatedButton(
              onPressed: (canProceed && !isLoading) ? onComplete : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text('Get Started  →'),
            ),
        ],
      ),
    );
  }
}

// ─── Page 1 — Welcome ─────────────────────────────────────────────────────────

class _WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              border: Border.all(color: AppTheme.primaryColor, width: 2),
            ),
            child: const Icon(
              Icons.shield,
              size: 56,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'ATT&CK Defender',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your personalized defensive cybersecurity advisor,\npowered by MITRE ATT&CK',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _Pill('110+ ATT&CK Techniques', Icons.category),
              _Pill('Personalized Threat Profile', Icons.person_pin),
              _Pill('AI-Powered Advice', Icons.auto_awesome),
              _Pill('Offline Capable', Icons.wifi_off),
              _Pill('PDF Reports', Icons.picture_as_pdf),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Page 2 — ATT&CK Explainer ───────────────────────────────────────────────

class _AttackExplainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is MITRE ATT&CK?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'A globally recognized knowledge base of real-world cyber attack methods, maintained by The MITRE Corporation.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          const _ExplCard(
            icon: Icons.map,
            color: AppTheme.primaryColor,
            title: '14 Attack Phases',
            body:
                'From "Gathering information" to "Causing damage" — the full attacker kill-chain.',
          ),
          const _ExplCard(
            icon: Icons.category,
            color: AppTheme.warningColor,
            title: '110+ Attack Techniques',
            body:
                'Specific methods attackers use, with real-world examples and detection guidance.',
          ),
          const _ExplCard(
            icon: Icons.account_tree,
            color: AppTheme.successColor,
            title: 'Sub-Techniques',
            body:
                'Detailed variants — e.g. T1566.001 means "Phishing via email attachment".',
          ),
          const _ExplCard(
            icon: Icons.shield,
            color: AppTheme.accentColor,
            title: 'Defensive Focus',
            body:
                'ATT&CK Defender uses this to measure what you\'re protected against — purely defensive, no hacking tools.',
          ),
        ],
      ),
    );
  }
}

// ─── Page 3 — Use Case ────────────────────────────────────────────────────────

class _UseCasePage extends StatelessWidget {
  final String? selected;
  final Function(String) onSelected;

  const _UseCasePage({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How will you use this app?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'This shapes your personalized threat profile.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          _UseCaseOption(
            id: 'personal',
            icon: Icons.school,
            label: 'Personal Learning',
            desc:
                'Student or security professional learning ATT&CK and defensive strategies.',
            selected: selected == 'personal',
            onTap: () => onSelected('personal'),
          ),
          const SizedBox(height: 12),
          _UseCaseOption(
            id: 'lab',
            icon: Icons.engineering,
            label: 'Lab / Research Environment',
            desc:
                'Security lab, red/blue team exercises, or academic research.',
            selected: selected == 'lab',
            onTap: () => onSelected('lab'),
          ),
          const SizedBox(height: 12),
          _UseCaseOption(
            id: 'organization',
            icon: Icons.business,
            label: 'Organization',
            desc:
                'Mapping and improving your organization\'s defensive coverage against real-world threats.',
            selected: selected == 'organization',
            onTap: () => onSelected('organization'),
          ),
        ],
      ),
    );
  }
}

// ─── Page 4 — Sector & Size ───────────────────────────────────────────────────

class _SectorSizePage extends StatelessWidget {
  final OrgSector sector;
  final OrgSize orgSize;
  final ValueChanged<OrgSector> onSectorChanged;
  final ValueChanged<OrgSize> onSizeChanged;

  const _SectorSizePage({
    required this.sector,
    required this.orgSize,
    required this.onSectorChanged,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Organization Profile',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Used to generate your personalized threat profile. Based on real threat intelligence for your sector.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),

          // Sector
          Text(
            'Industry / Sector',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          ...OrgSector.values.map(
            (s) => _SelectorCard(
              label: s.label,
              subtitle: s.description,
              selected: sector == s,
              onTap: () => onSectorChanged(s),
            ),
          ),
          const SizedBox(height: 20),

          // Size
          Text(
            'Organization Size',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: OrgSize.values
                .map(
                  (s) => GestureDetector(
                    onTap: () => onSizeChanged(s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: orgSize == s
                            ? AppTheme.primaryColor.withValues(alpha: 0.15)
                            : AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: orgSize == s
                              ? AppTheme.primaryColor
                              : Colors.grey.withValues(alpha: 0.3),
                          width: orgSize == s ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        s.label,
                        style: TextStyle(
                          color: orgSize == s
                              ? AppTheme.primaryColor
                              : Colors.grey,
                          fontWeight: orgSize == s
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Page 5 — Tech Stack & Controls ──────────────────────────────────────────

class _TechControlsPage extends StatelessWidget {
  final Set<TechStackItem> selectedTech;
  final Set<SecurityControl> selectedControls;
  final ValueChanged<TechStackItem> onTechToggled;
  final ValueChanged<SecurityControl> onControlToggled;

  const _TechControlsPage({
    required this.selectedTech,
    required this.selectedControls,
    required this.onTechToggled,
    required this.onControlToggled,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technology & Security Controls',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Select what you use. This personalizes which ATT&CK techniques matter most and pre-fills your coverage based on controls you already have.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),

          // Tech stack
          Row(
            children: [
              Text(
                'Technology Stack',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.dangerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Required',
                  style: TextStyle(
                    color: AppTheme.dangerColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: TechStackItem.values
                .map(
                  (t) => FilterChip(
                    label: Text(t.label, style: const TextStyle(fontSize: 12)),
                    selected: selectedTech.contains(t),
                    onSelected: (_) => onTechToggled(t),
                    selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryColor,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),

          // Security controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Controls You Already Have',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'These will auto-fill coverage suggestions. You can update them anytime.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...SecurityControl.values.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => onControlToggled(c),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selectedControls.contains(c)
                        ? AppTheme.successColor.withValues(alpha: 0.08)
                        : AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedControls.contains(c)
                          ? AppTheme.successColor.withValues(alpha: 0.5)
                          : Colors.grey.withValues(alpha: 0.2),
                      width: selectedControls.contains(c) ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedControls.contains(c)
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: selectedControls.contains(c)
                            ? AppTheme.successColor
                            : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.label,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: selectedControls.contains(c)
                                    ? AppTheme.successColor
                                    : Colors.white,
                              ),
                            ),
                            Text(
                              c.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppTheme.primaryColor,
                  size: 16,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Controls you select will auto-fill coverage for related ATT&CK techniques. You can always adjust manually.',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _Pill extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Pill(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppTheme.primaryColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  const _ExplCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseOption extends StatelessWidget {
  final String id;
  final IconData icon;
  final String label;
  final String desc;
  final bool selected;
  final VoidCallback onTap;

  const _UseCaseOption({
    required this.id,
    required this.icon,
    required this.label,
    required this.desc,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppTheme.primaryColor
        : Colors.grey.withValues(alpha: 0.5);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppTheme.primaryColor
                : Colors.grey.withValues(alpha: 0.3),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: selected ? AppTheme.primaryColor : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    desc,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: color,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _SelectorCard({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppTheme.primaryColor.withValues(alpha: 0.1)
                : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? AppTheme.primaryColor
                  : Colors.grey.withValues(alpha: 0.2),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: selected ? AppTheme.primaryColor : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
