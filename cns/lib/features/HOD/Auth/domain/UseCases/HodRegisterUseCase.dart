import 'package:cns/features/HOD/Auth/domain/repositories/HodAuthRepository.dart';

class HodRegisterUseCase {
  final HodAuthRepository _repository;

  HodRegisterUseCase(this._repository);

  Future<void> call({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String department,
  }) async {
    await _repository.registerHod(
      uid: uid,
      name: name,
      email: email,
      password: password,
      department: department,
    );
  }
}
