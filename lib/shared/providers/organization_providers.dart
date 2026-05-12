import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';

import 'plain_language_providers.dart';

part 'organization_providers.g.dart';

/// Current organization profile. Returns null if not set (triggers onboarding).
@Riverpod(keepAlive: false)
Future<OrganizationProfile?> organizationProfile(Ref ref) async {
  final current = ref.watch(organizationProfileV2Provider);

  if (current.hasValue) {
    return _legacyProfileFromV2(current.valueOrNull);
  }

  if (current.hasError) {
    return Future<OrganizationProfile?>.error(
      current.error!,
      current.stackTrace!,
    );
  }

  final completer = Completer<OrganizationProfile?>();
  ref.listen<AsyncValue<OrganizationProfileV2?>>(
    organizationProfileV2Provider,
    (_, next) {
      if (completer.isCompleted) {
        return;
      }

      if (next.hasValue) {
        completer.complete(_legacyProfileFromV2(next.valueOrNull));
      } else if (next.hasError) {
        completer.completeError(next.error!, next.stackTrace!);
      }
    },
  );

  return completer.future;
}

/// Save or update the organization profile.
@Riverpod(keepAlive: false)
Future<void> updateOrganizationProfile(
  Ref ref,
  OrganizationProfile profile,
) async {
  final existingV2 = ref.read(organizationProfileV2Provider).valueOrNull;
  final merged = _mergeLegacyProfile(profile, existingV2);
  await ref
      .read(organizationProfileV2Provider.notifier)
      .createOrUpdateProfile(merged);
  ref.invalidate(organizationProfileProvider);
}

/// Delete the organization profile (forces onboarding on next cold start).
@Riverpod(keepAlive: false)
Future<void> deleteOrganizationProfile(Ref ref) async {
  await ref.read(organizationProfileV2Provider.notifier).deleteProfile();
  ref.invalidate(organizationProfileProvider);
}

OrganizationProfile? _legacyProfileFromV2(OrganizationProfileV2? profile) {
  if (profile == null) {
    return null;
  }

  final techStack = switch (profile.technology) {
    PrimaryTechnology.windowsOnly => const [TechStackItem.windows],
    PrimaryTechnology.macOnly => const [TechStackItem.macos],
    PrimaryTechnology.linuxOnly => const [TechStackItem.linux],
    PrimaryTechnology.mixedOnPrem => const [
      TechStackItem.windows,
      TechStackItem.linux,
      TechStackItem.activeDirectory,
      TechStackItem.vmware,
    ],
    PrimaryTechnology.cloudPrimary => const [
      TechStackItem.aws,
      TechStackItem.azure,
      TechStackItem.gcp,
    ],
    PrimaryTechnology.hybrid => const [
      TechStackItem.windows,
      TechStackItem.linux,
      TechStackItem.aws,
    ],
  };

  final currentControls = profile.currentDefenses
      .map(
        (defense) => switch (defense) {
          ExistingDefenses.basicAv => SecurityControl.antivirus,
          ExistingDefenses.avAndFirewall => SecurityControl.firewall,
          ExistingDefenses.mfa => SecurityControl.mfa,
          ExistingDefenses.edr => SecurityControl.edr,
          ExistingDefenses.siem => SecurityControl.siem,
          ExistingDefenses.comprehensive => SecurityControl.patchManagement,
          ExistingDefenses.nothing => SecurityControl.none,
        },
      )
      .toSet()
      .toList();

  return OrganizationProfile(
    id: profile.id,
    name: profile.name,
    description: profile.description,
    context: _contextFromV2(profile),
    sector: _legacySector(profile.sector),
    orgSize: _legacyOrgSize(profile.size),
    techStack: techStack.map((item) => item.name).toList(),
    currentControls: currentControls.map((item) => item.name).toList(),
    preferredSectors: [profile.sector.displayName],
    preferredPlatforms: techStack.map((item) => item.label).toList(),
    createdAt: profile.createdAt,
    lastModified: profile.updatedAt,
  );
}

OrganizationProfileV2 _mergeLegacyProfile(
  OrganizationProfile profile,
  OrganizationProfileV2? existing,
) {
  final technology = _primaryTechnologyFromLegacy(profile, existing);
  final defenses = _existingDefensesFromLegacy(profile, existing);

  return OrganizationProfileV2(
    id: existing?.id ?? profile.id,
    name: profile.name,
    sector: _businessSectorFromLegacy(profile.sector, existing?.sector),
    size: _organizationSizeFromLegacy(profile.orgSize, existing?.size),
    technology: technology,
    currentDefenses: defenses,
    userTechLevel: existing?.userTechLevel ?? UserTechLevel.someTechnical,
    appMode: existing?.appMode ?? 'ExpertMode',
    baselineRiskScore: existing?.baselineRiskScore ?? 50.0,
    prioritizedTechniqueIds: existing?.prioritizedTechniqueIds ?? const [],
    suggestedCoverageLevels: existing?.suggestedCoverageLevels ?? const {},
    description: profile.description,
    createdAt: existing?.createdAt ?? profile.createdAt,
    updatedAt: profile.lastModified,
  );
}

String _contextFromV2(OrganizationProfileV2 profile) {
  if (profile.size == OrganizationSize.solo &&
      profile.sector == BusinessSector.other) {
    return 'Personal';
  }
  return 'Organization';
}

OrgSector _legacySector(BusinessSector sector) {
  return switch (sector) {
    BusinessSector.healthcare => OrgSector.healthcare,
    BusinessSector.finance => OrgSector.finance,
    BusinessSector.education => OrgSector.education,
    BusinessSector.retail => OrgSector.retail,
    BusinessSector.manufacturing => OrgSector.manufacturing,
    BusinessSector.government => OrgSector.government,
    BusinessSector.technology => OrgSector.technology,
    BusinessSector.hospitality => OrgSector.other,
    BusinessSector.nonprofit => OrgSector.sme,
    BusinessSector.other => OrgSector.other,
  };
}

OrgSize _legacyOrgSize(OrganizationSize size) {
  return switch (size) {
    OrganizationSize.solo => OrgSize.micro,
    OrganizationSize.small => OrgSize.small,
    OrganizationSize.medium => OrgSize.medium,
    OrganizationSize.largeSmall => OrgSize.large,
    OrganizationSize.large => OrgSize.enterprise,
  };
}

BusinessSector _businessSectorFromLegacy(
  OrgSector sector,
  BusinessSector? existing,
) {
  if (existing != null && sector == OrgSector.sme) {
    return existing;
  }

  return switch (sector) {
    OrgSector.healthcare => BusinessSector.healthcare,
    OrgSector.finance => BusinessSector.finance,
    OrgSector.education => BusinessSector.education,
    OrgSector.retail => BusinessSector.retail,
    OrgSector.government => BusinessSector.government,
    OrgSector.technology => BusinessSector.technology,
    OrgSector.manufacturing => BusinessSector.manufacturing,
    OrgSector.energy => BusinessSector.other,
    OrgSector.sme => BusinessSector.nonprofit,
    OrgSector.personal => BusinessSector.other,
    OrgSector.other => BusinessSector.other,
  };
}

OrganizationSize _organizationSizeFromLegacy(
  OrgSize size,
  OrganizationSize? existing,
) {
  if (existing != null && size == OrgSize.small) {
    return existing;
  }

  return switch (size) {
    OrgSize.micro => OrganizationSize.solo,
    OrgSize.small => OrganizationSize.small,
    OrgSize.medium => OrganizationSize.medium,
    OrgSize.large => OrganizationSize.largeSmall,
    OrgSize.enterprise => OrganizationSize.large,
  };
}

PrimaryTechnology _primaryTechnologyFromLegacy(
  OrganizationProfile profile,
  OrganizationProfileV2? existing,
) {
  if (profile.techStack.isEmpty) {
    return existing?.technology ?? PrimaryTechnology.hybrid;
  }

  final techSet = profile.techStack.toSet();
  if (techSet.contains(TechStackItem.windows.name) && techSet.length == 1) {
    return PrimaryTechnology.windowsOnly;
  }
  if (techSet.contains(TechStackItem.macos.name) && techSet.length == 1) {
    return PrimaryTechnology.macOnly;
  }
  if (techSet.contains(TechStackItem.linux.name) && techSet.length == 1) {
    return PrimaryTechnology.linuxOnly;
  }
  if (techSet.intersection({
        TechStackItem.aws.name,
        TechStackItem.azure.name,
        TechStackItem.gcp.name,
      }).isNotEmpty &&
      techSet.length <= 2) {
    return PrimaryTechnology.cloudPrimary;
  }
  if (techSet.contains(TechStackItem.activeDirectory.name) ||
      techSet.contains(TechStackItem.vmware.name)) {
    return PrimaryTechnology.mixedOnPrem;
  }
  return PrimaryTechnology.hybrid;
}

List<ExistingDefenses> _existingDefensesFromLegacy(
  OrganizationProfile profile,
  OrganizationProfileV2? existing,
) {
  if (profile.currentControls.isEmpty) {
    return existing?.currentDefenses ?? const [ExistingDefenses.nothing];
  }

  final mapped = profile.currentControls
      .map(
        (control) => switch (control) {
          'antivirus' => ExistingDefenses.basicAv,
          'firewall' => ExistingDefenses.avAndFirewall,
          'emailFiltering' => ExistingDefenses.avAndFirewall,
          'edr' => ExistingDefenses.edr,
          'siem' => ExistingDefenses.siem,
          'mfa' => ExistingDefenses.mfa,
          'none' => ExistingDefenses.nothing,
          _ => null,
        },
      )
      .whereType<ExistingDefenses>()
      .toSet()
      .toList();

  return mapped.isEmpty ? const [ExistingDefenses.nothing] : mapped;
}
