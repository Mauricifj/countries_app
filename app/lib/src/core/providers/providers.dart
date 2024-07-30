import 'package:provider/provider.dart';

import '../../authentication/controllers/auth_controller.dart';
import '../../dependency_injection.dart';

List<ChangeNotifierProvider> get providers {
  return [
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(
        authService: serviceLocator(),
        storage: serviceLocator(),
      ),
    ),

    ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(
        serviceLocator(),
      ),
    ),
  ];
}
