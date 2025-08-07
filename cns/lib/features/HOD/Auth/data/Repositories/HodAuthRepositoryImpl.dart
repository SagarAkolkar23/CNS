import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/features/HOD/Auth/domain/repositories/HodAuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HodAuthRepositoryImpl implements HodAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> loginHod({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> registerHod({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String department,
  }) async {
    final uidDoc = await _firestore.collection('HOD_Id').doc(uid).get();

     if (!uidDoc.exists) {
      throw Exception('Invalid UID');
    }

    if (uidDoc.data()?['registered'] == true) {
      throw Exception('HOD already registered');
    }
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final authUid = userCredential.user!.uid;

    await _firestore.collection('registeredHod').doc(authUid).set({
      'uid' : authUid,
      'name': name,
      'email': email,
      'role': 'hod',
      'department': department,
    });
        await _firestore.collection('HOD_Id').doc(uid).update({
      'registered': true,
    });

  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
