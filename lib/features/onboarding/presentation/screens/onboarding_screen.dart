import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attackshield/core/constants/constants.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;
  String? _selectedUseCase; // 'personal', 'lab', 'organization'

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageCtrl.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageCtrl.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    if (_selectedUseCase == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select how you will use ATT&CK Defender'),
          backgroundColor: AppTheme.warningColor,
        ),
      );
      return;
    }

    // Save onboarding complete flag
    final storage = GetStorage();
    await storage.write(AppConstants.storageKeyOnboardingComplete, true);

    // Create a default org profile based on use case
    final orgName = switch (_selectedUseCase) {
      'personal' => 'Personal Learning',
      'lab' => 'Lab Environment',
      'organization' => 'My Organization',
      _ => 'ATT&CK Defender User',
    };
    final orgContext = switch (_selectedUseCase) {
      'personal' => AppContext.personalLearning,
      'lab' => AppContext.lab,
      'organization' => AppContext.organizational,
      _ => AppContext.personalLearning,
    };

    final profile = OrganizationProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: orgName,
      context: orgContext,
      description: 'Created during onboarding.',
      preferredSectors: [],
      preferredPlatforms: [],
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
    );

    await ref.read(updateOrganizationProfileProvider(profile).future);

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Progress indicator ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: List.generate(3, (i) {
                  final isActive = i <= _currentPage;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                      height: 4,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.primaryColor
                            : AppTheme.primaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${_currentPage + 1} of 3',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // ── Pages ──────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _WelcomePage(),
                  _AttackExplainerPage(),
                  _UseCasePage(
                    selectedUseCase: _selectedUseCase,
                    onSelected: (uc) => setState(() => _selectedUseCase = uc),
                  ),
                ],
              ),
            ),

            // ── Bottom nav ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    OutlinedButton(
                      onPressed: _prevPage,
                      child: const Text('Back'),
                    )
                  else
                    const SizedBox(width: 80),
                  const Spacer(),
                  // Dot indicators
                  Row(
                    children: List.generate(3, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppTheme.primaryColor
                              : AppTheme.primaryColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  if (_currentPage < 2)
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: const Text('Next'),
                    )
                  else
                    ElevatedButton(
                      onPressed: _completeOnboarding,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Get Started →',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
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
          // App icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryColor.withValues(alpha: 0.12),
              border: Border.all(color: AppTheme.primaryColor, width: 2),
            ),
            child: const Icon(
              Icons.shield,
              size: 60,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'ATT&CK Defender',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Defensive Cybersecurity Intelligence',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Feature pills
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _FeaturePill('110+ ATT&CK Techniques', Icons.category),
              _FeaturePill('Risk Engine', Icons.analytics),
              _FeaturePill('Coverage Matrix', Icons.grid_on),
              _FeaturePill('PDF Reports', Icons.picture_as_pdf),
              _FeaturePill('Readiness Simulations', Icons.science),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final String label;
  final IconData icon;
  const _FeaturePill(this.label, this.icon);

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
          Icon(icon, size: 14, color: AppTheme.primaryColor),
          const SizedBox(width: 6),
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

// ─── Page 2 — ATT&CK Explainer ───────────────────────────────────────────────

class _AttackExplainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'What is MITRE ATT&CK?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'MITRE ATT&CK® is a globally recognized knowledge base of real-world '
            'adversary tactics and techniques, maintained by The MITRE Corporation.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const _ExplainerCard(
            icon: Icons.map,
            color: AppTheme.primaryColor,
            title: '14 Tactics',
            body:
                'From Reconnaissance and Initial Access through to Impact — the full attacker kill-chain.',
          ),
          const _ExplainerCard(
            icon: Icons.category,
            color: AppTheme.warningColor,
            title: '110+ Techniques',
            body:
                'Specific attack methods with detection ideas, mitigations, and affected platforms.',
          ),
          const _ExplainerCard(
            icon: Icons.account_tree,
            color: AppTheme.successColor,
            title: 'Sub-Techniques',
            body:
                'Detailed variants of parent techniques — e.g. T1566.001 Spearphishing Attachment.',
          ),
          const _ExplainerCard(
            icon: Icons.shield,
            color: AppTheme.accentColor,
            title: 'Defensive Focus',
            body:
                'ATT&CK Defender uses this framework to measure what you\'re protected against — not to attack.',
          ),
        ],
      ),
    );
  }
}

class _ExplainerCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _ExplainerCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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

// ─── Page 3 — Use Case Selection ─────────────────────────────────────────────

class _UseCasePage extends StatelessWidget {
  final String? selectedUseCase;
  final Function(String) onSelected;

  const _UseCasePage({required this.selectedUseCase, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How will you use\nATT&CK Defender?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This helps personalize your experience.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32),

          _UseCaseOption(
            id: 'personal',
            icon: Icons.school,
            label: 'Personal Learning',
            description:
                'I\'m a student or security professional learning about ATT&CK techniques and defensive strategies.',
            selected: selectedUseCase == 'personal',
            onTap: () => onSelected('personal'),
          ),
          const SizedBox(height: 12),
          _UseCaseOption(
            id: 'lab',
            icon: Icons.engineering,
            label: 'Lab / Research Environment',
            description:
                'I\'m running a security lab, red/blue team exercises, or academic research.',
            selected: selectedUseCase == 'lab',
            onTap: () => onSelected('lab'),
          ),
          const SizedBox(height: 12),
          _UseCaseOption(
            id: 'organization',
            icon: Icons.business,
            label: 'Organization',
            description:
                'I\'m mapping and improving my organization\'s defensive coverage against real-world threats.',
            selected: selectedUseCase == 'organization',
            onTap: () => onSelected('organization'),
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
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const _UseCaseOption({
    required this.id,
    required this.icon,
    required this.label,
    required this.description,
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
              child: Icon(icon, color: color, size: 24),
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
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
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
