import 'package:cns/features/HOD/Auth/data/Repositories/HodAuthRepositoryImpl.dart';
import 'package:cns/features/HOD/Auth/domain/UseCases/HodLoginUseCases.dart';
import 'package:cns/features/HOD/Auth/domain/UseCases/HodLogoutUseCae.dart';
import 'package:cns/features/HOD/Auth/domain/UseCases/HodRegisterUseCase.dart';
import 'package:cns/features/HOD/Auth/domain/repositories/HodAuthRepository.dart';
import 'package:cns/features/HOD/Auth/presentation/Controller/HodAuthController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hodAuthRepositoryProvider = Provider<HodAuthRepository>((ref) {
  return HodAuthRepositoryImpl();
});

/// Provide the usecases
final loginHodUseCaseProvider = Provider<HodLoginUseCase>((ref) {
  return HodLoginUseCase(ref.watch(hodAuthRepositoryProvider));
});

final registerHodUseCaseProvider = Provider<HodRegisterUseCase>((ref) {
  return HodRegisterUseCase(ref.watch(hodAuthRepositoryProvider));
});

final logoutUseCaseProvider = Provider<HodLogoutUseCase>((ref) {
  return HodLogoutUseCase(ref.watch(hodAuthRepositoryProvider));
});


/// Provide the controller
final hodAuthControllerProvider =
    StateNotifierProvider<HodAuthController, AsyncValue<void>>((ref) {
      return HodAuthController(
        hodLoginUseCase: ref.watch(loginHodUseCaseProvider),
        hodRegisterUseCase: ref.watch(registerHodUseCaseProvider),
        hodLogoutUseCase: ref.watch(logoutUseCaseProvider),
      );
    });
