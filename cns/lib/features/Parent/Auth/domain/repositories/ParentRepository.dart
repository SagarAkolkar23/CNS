import 'package:cns/features/Parent/Auth/domain/entities/Parent.dart';

abstract class ParentRepository {
  Future<void> registerParent(Parent parent, {required String hodId});
  Future<bool> isParentLocallyRegistered();
  Future<Map<String, String>?> getLocalParentData();
  Future<void> clearLocalParentData();
}
