import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'organization_providers.g.dart';

/// Current organization profile. Returns null if not set (triggers onboarding).
@Riverpod(keepAlive: false)
Future<OrganizationProfile?> organizationProfile(Ref ref) async {
  final repository = ref.watch(organizationRepositoryProvider);
  return repository.getOrganizationProfile();
}

/// Save or update the organization profile.
@Riverpod(keepAlive: false)
Future<void> updateOrganizationProfile(
    Ref ref, OrganizationProfile profile) async {
  final repository = ref.watch(organizationRepositoryProvider);
  await repository.saveOrganizationProfile(profile);
  ref.invalidate(organizationProfileProvider);
}

/// Delete the organization profile (forces onboarding on next cold start).
@Riverpod(keepAlive: false)
Future<void> deleteOrganizationProfile(Ref ref) async {
  final repository = ref.watch(organizationRepositoryProvider);
  await repository.deleteOrganizationProfile();
  ref.invalidate(organizationProfileProvider);
}