// lib/features/parents/data/datasources/parent_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/features/Parent/Auth/data/models/ParentModel.dart';

abstract class ParentRemoteDataSource {
  Future<void> saveParent(ParentModel parent);
}

class ParentRemoteDataSourceImpl implements ParentRemoteDataSource {
  final FirebaseFirestore firestore;

  ParentRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> saveParent(ParentModel parent) async {
    // 1️⃣ Find the HOD ID for the given department
    final hodSnapshot = await firestore
        .collection('registeredHod')
        .where('department', isEqualTo: parent.branch)
        .limit(1)
        .get();

    if (hodSnapshot.docs.isEmpty) {
      throw Exception('No HOD found for department: ${parent.branch}');
    }

    final hodDoc = hodSnapshot.docs.first;
    final hodId = hodDoc.id;

    // 2️⃣ Save parent in top-level collection for direct lookup
    await firestore
        .collection('parents')
        .doc(parent.fcmToken)
        .set(parent.toMap());

    // 3️⃣ Instead of subcollection, update existing "years/{year}" document
    final yearDocRef = firestore
        .collection('registeredHod')
        .doc(hodId)
        .collection('years')
        .doc(parent.year);

    await yearDocRef.set({
      'parents': FieldValue.arrayUnion([
        {
          'fcmToken': parent.fcmToken,
        },
      ]),
    }, SetOptions(merge: true));
  }

}
