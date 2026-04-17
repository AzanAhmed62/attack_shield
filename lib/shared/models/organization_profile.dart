import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_profile.freezed.dart';
part 'organization_profile.g.dart';

/// Industry sector of the organization.
enum OrgSector {
  healthcare,
  finance,
  education,
  retail,
  government,
  technology,
  manufacturing,
  energy,
  sme,      // Small / Medium Enterprise (generic)
  personal, // Individual learner
  other,
}

/// Organization size by headcount.
enum OrgSize {
  micro,    // 1–10
  small,    // 11–50
  medium,   // 51–200
  large,    // 201–1000
  enterprise, // 1000+
}

/// Technology / platform in use.
/// Multiple selections allowed.
enum TechStackItem {
  windows,
  macos,
  linux,
  office365,
  googleWorkspace,
  aws,
  azure,
  gcp,
  activeDirectory,
  vmware,
  containers,
  iot,
  networkDevices,
}

/// Security controls already deployed.
/// Multiple selections allowed.
enum SecurityControl {
  antivirus,
  firewall,
  emailFiltering,
  edr,     // Endpoint Detection & Response
  siem,    // Security Information & Event Management
  mfa,     // Multi-Factor Authentication
  vpn,
  dlp,     // Data Loss Prevention
  iam,     // Identity & Access Management
  backups,
  patchManagement,
  securityAwareness,
  none,
}

extension OrgSectorX on OrgSector {
  String get label {
    switch (this) {
      case OrgSector.healthcare:       return 'Healthcare';
      case OrgSector.finance:          return 'Finance & Banking';
      case OrgSector.education:        return 'Education';
      case OrgSector.retail:           return 'Retail & E-Commerce';
      case OrgSector.government:       return 'Government & Public Sector';
      case OrgSector.technology:       return 'Technology & Software';
      case OrgSector.manufacturing:    return 'Manufacturing';
      case OrgSector.energy:           return 'Energy & Utilities';
      case OrgSector.sme:              return 'Small / Medium Business';
      case OrgSector.personal:         return 'Personal / Home User';
      case OrgSector.other:            return 'Other';
    }
  }

  String get description {
    switch (this) {
      case OrgSector.healthcare:    return 'Hospitals, clinics, pharma';
      case OrgSector.finance:       return 'Banks, insurance, fintech';
      case OrgSector.education:     return 'Schools, universities, e-learning';
      case OrgSector.retail:        return 'Stores, marketplaces, supply chain';
      case OrgSector.government:    return 'Public agencies, military, local gov';
      case OrgSector.technology:    return 'SaaS, software development, IT';
      case OrgSector.manufacturing: return 'Industrial, automotive, aerospace';
      case OrgSector.energy:        return 'Power, oil & gas, water utilities';
      case OrgSector.sme:           return 'General small or medium business';
      case OrgSector.personal:      return 'Individual learner or home lab';
      case OrgSector.other:         return 'Other industry';
    }
  }
}

extension OrgSizeX on OrgSize {
  String get label {
    switch (this) {
      case OrgSize.micro:      return '1–10 people';
      case OrgSize.small:      return '11–50 people';
      case OrgSize.medium:     return '51–200 people';
      case OrgSize.large:      return '201–1,000 people';
      case OrgSize.enterprise: return '1,000+ people';
    }
  }
}

extension TechStackItemX on TechStackItem {
  String get label {
    switch (this) {
      case TechStackItem.windows:          return 'Windows';
      case TechStackItem.macos:            return 'macOS';
      case TechStackItem.linux:            return 'Linux';
      case TechStackItem.office365:        return 'Microsoft Office 365';
      case TechStackItem.googleWorkspace:  return 'Google Workspace';
      case TechStackItem.aws:              return 'AWS';
      case TechStackItem.azure:            return 'Azure';
      case TechStackItem.gcp:              return 'Google Cloud (GCP)';
      case TechStackItem.activeDirectory:  return 'Active Directory';
      case TechStackItem.vmware:           return 'VMware / Virtualisation';
      case TechStackItem.containers:       return 'Containers / Kubernetes';
      case TechStackItem.iot:              return 'IoT / OT Devices';
      case TechStackItem.networkDevices:   return 'Network Devices (Cisco, etc.)';
    }
  }
}

extension SecurityControlX on SecurityControl {
  String get label {
    switch (this) {
      case SecurityControl.antivirus:         return 'Antivirus / Anti-Malware';
      case SecurityControl.firewall:          return 'Firewall (Network/Host)';
      case SecurityControl.emailFiltering:    return 'Email Filtering / Gateway';
      case SecurityControl.edr:               return 'EDR (CrowdStrike, Defender, etc.)';
      case SecurityControl.siem:              return 'SIEM (Splunk, Sentinel, etc.)';
      case SecurityControl.mfa:               return 'Multi-Factor Authentication (MFA)';
      case SecurityControl.vpn:               return 'VPN';
      case SecurityControl.dlp:               return 'Data Loss Prevention (DLP)';
      case SecurityControl.iam:               return 'Identity & Access Management';
      case SecurityControl.backups:           return 'Regular Backups';
      case SecurityControl.patchManagement:   return 'Patch Management Process';
      case SecurityControl.securityAwareness: return 'Security Awareness Training';
      case SecurityControl.none:              return 'None of the above';
    }
  }

  String get description {
    switch (this) {
      case SecurityControl.antivirus:         return 'Signature/heuristic malware detection';
      case SecurityControl.firewall:          return 'Network traffic filtering';
      case SecurityControl.emailFiltering:    return 'Spam/phishing/attachment scanning';
      case SecurityControl.edr:               return 'Behavioral endpoint monitoring & response';
      case SecurityControl.siem:              return 'Centralised log analysis and alerting';
      case SecurityControl.mfa:               return 'Second factor for logins';
      case SecurityControl.vpn:               return 'Encrypted remote access tunnel';
      case SecurityControl.dlp:               return 'Prevent sensitive data leaving the org';
      case SecurityControl.iam:               return 'Centralised identity and access control';
      case SecurityControl.backups:           return 'Regular, tested data backups';
      case SecurityControl.patchManagement:   return 'Systematic software patching process';
      case SecurityControl.securityAwareness: return 'Staff phishing awareness training';
      case SecurityControl.none:              return 'No security controls currently deployed';
    }
  }
}

/// Full organization profile — the heart of the threat profiling system.
@freezed
class OrganizationProfile with _$OrganizationProfile {
  const factory OrganizationProfile({
    required String id,
    required String name,
    @Default('') String description,

    // Use-case context from onboarding
    @Default('Organization') String context, // 'Personal Learning' | 'Lab' | 'Organization'

    // New: structured profile fields
    @Default(OrgSector.sme) OrgSector sector,
    @Default(OrgSize.small) OrgSize orgSize,
    @Default([]) List<String> techStack,           // TechStackItem.name values
    @Default([]) List<String> currentControls,      // SecurityControl.name values

    // Legacy fields kept for compatibility
    @Default([]) List<String> preferredSectors,
    @Default([]) List<String> preferredPlatforms,

    required DateTime createdAt,
    required DateTime lastModified,
  }) = _OrganizationProfile;

  factory OrganizationProfile.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProfileFromJson(json);
}

/// Helpers to convert between enum and stored string lists.
extension OrganizationProfileX on OrganizationProfile {
  List<TechStackItem> get techStackItems => techStack
      .map((s) {
        try {
          return TechStackItem.values.firstWhere((e) => e.name == s);
        } catch (_) {
          return null;
        }
      })
      .whereType<TechStackItem>()
      .toList();

  List<SecurityControl> get securityControlItems => currentControls
      .map((s) {
        try {
          return SecurityControl.values.firstWhere((e) => e.name == s);
        } catch (_) {
          return null;
        }
      })
      .whereType<SecurityControl>()
      .toList();

  bool get isProfileComplete =>
      name.isNotEmpty && techStack.isNotEmpty;
}