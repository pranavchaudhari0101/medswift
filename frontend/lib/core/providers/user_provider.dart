import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_models.dart';
import '../network/dio_client.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref.watch(dioClientProvider));
});

/// Current user profile.
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final service = ref.watch(userServiceProvider);
  return service.getProfile();
});

/// User's saved addresses.
final addressesProvider = FutureProvider<List<UserAddress>>((ref) async {
  final service = ref.watch(userServiceProvider);
  return service.getAddresses();
});
