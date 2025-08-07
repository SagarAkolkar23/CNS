import 'package:cns/core/Routing/AppRouter.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "CNS", 
      routerConfig: AppRouter.router,
    );
  }
}
