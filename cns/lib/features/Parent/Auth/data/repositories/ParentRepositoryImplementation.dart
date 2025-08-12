// lib/features/parents/data/repositories/parent_repository_impl.dart
import 'package:cns/core/services/LocalStorageService.dart';
import 'package:cns/features/Parent/Auth/data/models/ParentModel.dart';
import 'package:cns/features/Parent/Auth/data/sources/ParentRemoteDataSource.dart';
import 'package:cns/features/Parent/Auth/domain/repositories/ParentRepository.dart';
import 'package:cns/features/Parent/Auth/domain/entities/Parent.dart';

class ParentRepositoryImpl implements ParentRepository {
  final ParentRemoteDataSource remote;
  final LocalStorageService local;

  ParentRepositoryImpl({required this.remote, required this.local});

  @override
  Future<void> registerParent(Parent parent, {required String hodId}) async {
    final model = ParentModel(
      branch: parent.branch,
      year: parent.year,
      fcmToken: parent.fcmToken,
      registeredAt: parent.registeredAt,
    );
    await remote.saveParent(model);
    await local.saveParentData(
      branch: parent.branch,
      year: parent.year,
      fcmToken: parent.fcmToken,
    );
  }

  @override
  Future<bool> isParentLocallyRegistered() async {
    final data = await local.getParentData();
    return data != null;
  }

  @override
  Future<Map<String, String>?> getLocalParentData() async {
    return await local.getParentData();
  }

  @override
  Future<void> clearLocalParentData() async {
    await local.clearParentData();
  }
}
