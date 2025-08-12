import 'package:cns/features/HOD/Auth/presentation/Screens/HODLoginScreen.dart';
import 'package:cns/features/HOD/Auth/presentation/Screens/HodSignUpScreen.dart';
import 'package:cns/features/HOD/Dashboard/presentation/Screens/HodHomeScreen.dart';
import 'package:cns/features/Parent/Auth/presentation/Screens/ParentStartScreen.dart';
import 'package:cns/features/Parent/Dashboard/presentation/Screens/ParentHomeScreen.dart';
import 'package:cns/features/SelectUser/presentation/SelectUser.dart';
import 'package:cns/features/SplashScreen/presentation/Screens/SplashScreen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/SelectUser', builder: (context, state) => SelectUser()),
      GoRoute(
        path: '/Hod/Login',
        builder: (context, state) => HodLoginScreen(),
      ),
      GoRoute(
        path: '/Hod/Register',
        builder: (context, state) => HodSignupScreen(),
      ),
      GoRoute(
        path: '/Hod/HomeScreen',
        builder: (context, state) => HodHomeScreen(),
      ),
      GoRoute(
        path: '/Parent/Start',
        builder: (context, state) => ParentStartScreen(),
      ),
      GoRoute(
        path: '/Parent/HomeScreen',
        builder: (context, state) => ParentHomeScreen(),
      ),
    ],
  );
}
