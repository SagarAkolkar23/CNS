import 'package:cns/features/SelectUser/presentation/SelectUser.dart';
import 'package:cns/features/SplashScreen/presentation/Screens/SplashScreen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/', 
        builder: (context, state) => SplashScreen()
        ),
        GoRoute(
        path: '/SelectUser',
        builder: (context, state) => SelectUser()
        )
      ],
  );
}
