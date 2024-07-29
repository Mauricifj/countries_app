import 'package:countries_app/src/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../authentication/controllers/auth_controller.dart';

List<ChangeNotifierProvider> get providers {
  return [
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(
        authService: serviceLocator(),
        storage: serviceLocator(),
      ),
    ),
  ];
}
