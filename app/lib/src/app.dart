import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/providers.dart';
import 'config/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        routes: AppRouter.routes,
        initialRoute: AppRouter.splash,
      ),
    );
  }
}
