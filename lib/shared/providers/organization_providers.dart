import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'organization_providers.g.dart';

@Riverpod()
Future<OrganizationProfile?> organizationProfile(
  OrganizationProfileRef ref,
) async {
  final repository = ref.watch(organizationRepositoryProvider);
  return repository.getProfile();
}

@Riverpod()
Future<String> organizationName(OrganizationNameRef ref) async {
  final profile = await ref.watch(organizationProfileProvider.future);
  return profile?.name ?? 'Your Organization';
}

@Riverpod()
Future<String> organizationContext(OrganizationContextRef ref) async {
  final profile = await ref.watch(organizationProfileProvider.future);
  return profile?.context.toString().split('.').last ?? 'personalLearning';
}

@Riverpod()
Future<void> createOrganizationProfile(
  CreateOrganizationProfileRef ref,
  OrganizationProfile profile,
) async {
  final repository = ref.watch(organizationRepositoryProvider);
  await repository.createProfile(profile);
  ref.invalidate(organizationProfileProvider);
}

@Riverpod()
Future<void> updateOrganizationProfile(
  UpdateOrganizationProfileRef ref,
  OrganizationProfile profile,
) async {
  final repository = ref.watch(organizationRepositoryProvider);
  await repository.updateProfile(profile);
  ref.invalidate(organizationProfileProvider);
}
