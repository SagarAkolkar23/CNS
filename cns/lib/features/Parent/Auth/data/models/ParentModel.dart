import 'package:cns/features/Parent/Auth/domain/entities/Parent.dart';

class ParentModel extends Parent {
  const ParentModel({
    required super.branch,
    required super.year,
    required super.fcmToken,
    required super.registeredAt,
  });

  Map<String, dynamic> toMap() => {
    'branch': branch,
    'year': year,
    'fcmToken': fcmToken,
    'registeredAt': registeredAt.toIso8601String(),
  };

  factory ParentModel.fromMap(Map<String, dynamic> map) {
    return ParentModel(
      branch: map['branch'] as String,
      year: map['year'] as String,
      fcmToken: map['fcmToken'] as String,
      registeredAt: DateTime.parse(map['registeredAt'] as String),
    );
  }
}
