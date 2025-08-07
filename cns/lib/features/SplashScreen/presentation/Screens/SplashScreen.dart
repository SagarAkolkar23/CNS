import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final role = await getUserRole(user.uid);
      if (role == "hod") {
        context.go("/Hod/HomeScreen");
      } else if (role == "parent") {
        context.go("/Parent/HomeScreen");
      } else {
        context.go("/SelectUser"); // fallback in case role is invalid
      }
    } else {
      context.go("/SelectUser");
    }
  }

  Future<String?> getUserRole(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      return doc.data()?['role'] as String?;
    }
    return null;
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
