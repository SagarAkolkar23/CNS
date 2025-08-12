// lib/features/parents/presentation/providers/parents_providers.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/core/services/LocalStorageService.dart';
import 'package:cns/features/Parent/Auth/data/repositories/ParentRepositoryImplementation.dart';
import 'package:cns/features/Parent/Auth/data/sources/ParentRemoteDataSource.dart';
import 'package:cns/features/Parent/Auth/domain/usecases/RegisterParentUseCase.dart';
import 'package:cns/features/Parent/Auth/presentation/Controller/ParentController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// CORE providers
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// DATA layer
final parentRemoteDataSourceProvider = Provider<ParentRemoteDataSource>((ref) {
  return ParentRemoteDataSourceImpl(ref.read(firebaseFirestoreProvider));
});

final parentRepositoryProvider = Provider<ParentRepositoryImpl>((ref) {
  return ParentRepositoryImpl(
    remote: ref.read(parentRemoteDataSourceProvider),
    local: ref.read(localStorageServiceProvider),
  );
});

/// USECASE
final registerParentUseCaseProvider = Provider<RegisterParentUseCase>((ref) {
  return RegisterParentUseCase(ref.read(parentRepositoryProvider));
});

/// CONTROLLER
final parentsControllerProvider =
    StateNotifierProvider<ParentsController, AsyncValue<void>>((ref) {
      // For demo purposes, inject a HOD id. Replace with dynamic HOD lookup.
      const demoHodId = 'hod_demo_001';
      return ParentsController(
        registerParent: ref.read(registerParentUseCaseProvider),
        hodIdForDemo: demoHodId,
      );
    });

/// helpers for checking local registration directly from repo
final isParentRegisteredLocallyProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(parentRepositoryProvider);
  return repo.isParentLocallyRegistered();
});

final getLocalParentDataProvider = FutureProvider<Map<String, String>?>((
  ref,
) async {
  final repo = ref.read(parentRepositoryProvider);
  return repo.getLocalParentData();
});
