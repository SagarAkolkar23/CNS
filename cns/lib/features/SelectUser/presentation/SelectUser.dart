import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';


class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101820),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Title
                Text(
                  "Welcome to CNS",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Choose your role to continue",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // HOD Card
                _buildUserCard(
                  context,
                  title: "Login as HOD",
                  icon: Icons.school_rounded,
                  color: Colors.blueAccent,
                  routeName: '/Hod/Login',
                ),
                const SizedBox(height: 20),

                // Parent Card
                _buildUserCard(
                  context,
                  title: "Login as Parent",
                  icon: Icons.family_restroom_rounded,
                  color: Colors.pinkAccent,

                  routeName: '/Parent/Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String routeName,
  }) {
    return GestureDetector(
      onTap: () => context.go(routeName),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white70,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
