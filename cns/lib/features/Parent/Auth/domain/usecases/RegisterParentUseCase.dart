// lib/features/parents/domain/usecases/register_parent_usecase.dart
import 'package:cns/features/Parent/Auth/data/repositories/ParentRepositoryImplementation.dart';
import 'package:cns/features/Parent/Auth/domain/entities/Parent.dart';

class RegisterParentUseCase {
  final ParentRepositoryImpl repository;
  RegisterParentUseCase(this.repository);

  Future<void> call(Parent parent, {required String hodId}) {
    return repository.registerParent(parent, hodId: hodId);
  }
}
