import 'package:countries_app/src/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries App'),
        actions: [
          IconButton(
            onPressed: () async {
              final controller = context.read<AuthController>();
              await controller.logout();

              if (!context.mounted) {
                return;
              }

              Navigator.pushReplacementNamed(context, AppRouter.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
