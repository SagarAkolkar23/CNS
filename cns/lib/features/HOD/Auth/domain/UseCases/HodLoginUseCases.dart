import 'package:cns/features/HOD/Auth/domain/repositories/HodAuthRepository.dart';

class HodLoginUseCase {
  final HodAuthRepository _repository;

  HodLoginUseCase(this._repository);

  Future<void> call({required String email, required String password}) async {
    await _repository.loginHod(email: email, password: password);
  }
}
