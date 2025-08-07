import 'package:cns/features/HOD/Auth/domain/repositories/HodAuthRepository.dart';

class HodLogoutUseCase {
  final HodAuthRepository _repository;

  HodLogoutUseCase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
