abstract class HodAuthRepository {
  Future<void> loginHod({required String email, required String password});

  Future<void> registerHod({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String department,
  });

  Future<void> logout();
}
