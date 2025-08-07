import 'package:cns/features/HOD/Auth/domain/UseCases/HodLoginUseCases.dart';
import 'package:cns/features/HOD/Auth/domain/UseCases/HodLogoutUseCae.dart';
import 'package:cns/features/HOD/Auth/domain/UseCases/HodRegisterUseCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HodAuthController extends StateNotifier<AsyncValue<void>> {
  final HodLoginUseCase hodLoginUseCase;
  final HodRegisterUseCase hodRegisterUseCase;
  final HodLogoutUseCase hodLogoutUseCase;

  HodAuthController({
    required this.hodLoginUseCase,
    required this.hodLogoutUseCase,
    required this.hodRegisterUseCase,
  }) : super(const AsyncData(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      await hodLoginUseCase(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> register({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String department,
  }) async {
    state = const AsyncLoading();
    try {
      await hodRegisterUseCase(
        uid: uid,
        name: name,
        email: email,
        password: password,
        department: department,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
    Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await hodLogoutUseCase();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
