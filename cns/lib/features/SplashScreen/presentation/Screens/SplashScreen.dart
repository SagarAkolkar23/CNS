import 'package:cns/features/Parent/Auth/domain/repositories/ParentRepository.dart';
import 'package:cns/features/Parent/Auth/presentation/provider/ParentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final splashControllerProvider = Provider<SplashController>((ref) {
  return SplashController(parentRepository: ref.read(parentRepositoryProvider));
});

class SplashController {
  final ParentRepository parentRepository;
  SplashController({required this.parentRepository});

  Future<void> decideNavigation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    // 1️⃣ Check if HOD logged in via FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Read Firestore for HOD role
      // This assumes 'role' is stored in users/{uid}
      final role = await getUserRole(user.uid);
      if (role == "hod") {
        context.go("/Hod/HomeScreen");
        return;
      }
    }

    // 2️⃣ Check if Parent is locally registered
    final isParentRegistered = await parentRepository
        .isParentLocallyRegistered();
    if (isParentRegistered) {
      context.go("/Parent/HomeScreen");
      return;
    }

    // 3️⃣ Fallback: Go to user selection
    context.go("/SelectUser");
  }

  Future<String?> getUserRole(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('registeredHod')
        .doc(uid)
        .get();
    if (doc.exists) {
      return doc.data()?['role'] as String?;
    }
    return null;
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(splashControllerProvider).decideNavigation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101820),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white12,
              ),
              child: const Icon(
                Icons.notifications_active_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "CNS",
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            Text(
              "College Notification System",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
