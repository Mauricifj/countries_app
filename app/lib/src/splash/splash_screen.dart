import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../authentication/controllers/auth_controller.dart';
import '../config/app_router.dart';
import '../core/style/spacings.dart';
import '../core/widgets/loading_widget.dart';
import '../core/widgets/logo_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LogoIcon(size: 75),
          Center(child: Text('Countries App', style: titleTextStyle)),
          Spacings.xxxl.verticalSpacing,
          const LoadingWidget(size: 32),
        ],
      ),
    );
  }

  void _checkAuthentication() async {
    final authController = context.read<AuthController>();
    await authController.init();

    final state = authController.state;
    if (context.mounted && state.isAuthenticated) {
      return _navigateTo(AppRouter.home);
    }

    if (context.mounted) {
      return _navigateTo(AppRouter.loginName);
    }
  }

  void _navigateTo(String route) {
    context.pushReplacementNamed(route);
  }
}
