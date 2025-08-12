// lib/features/parents/presentation/controllers/parents_controller.dart
import 'package:cns/features/Parent/Auth/domain/usecases/RegisterParentUseCase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cns/features/Parent/Auth/domain/entities/Parent.dart';

class ParentsController extends StateNotifier<AsyncValue<void>> {
  final RegisterParentUseCase registerParent;
  final String hodIdForDemo; // for demo, inject which hod id to store under

  ParentsController({required this.registerParent, required this.hodIdForDemo})
    : super(const AsyncData(null));

  /// Register parent: obtain FCM token -> call usecase -> subscribe to topic if desired
  Future<void> register({required String branch, required String year}) async {
    state = const AsyncLoading();
    try {
      // get FCM token to use as device id
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) throw Exception('Unable to obtain FCM token');

      final parent = Parent(
        branch: branch,
        year: year,
        fcmToken: fcmToken,
        registeredAt: DateTime.now(),
      );

      // register in firestore and save locally via repository
      await registerParent(parent, hodId: hodIdForDemo);

      // optional: subscribe to topic for easier broadcast
      await FirebaseMessaging.instance.subscribeToTopic('${branch}_$year');

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<bool> checkIfRegisteredLocally() async {
    // delegate to repository via usecase's repository (we'll expose a small helper in provider)
    // We'll implement a helper provider to check local registration (see providers file).
    throw UnimplementedError();
  }

  Future<void> logoutAndClearLocal(
    BuildContext context,
    void Function() onDone,
  ) async {
    state = const AsyncLoading();
    try {
      state = const AsyncData(null);
      onDone();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
