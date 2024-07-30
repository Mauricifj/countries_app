import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../authentication/controllers/auth_controller.dart';
import '../authentication/pages/login_page.dart';
import '../country_details/country_details_page.dart';
import '../home/home_page.dart';
import '../splash/splash_screen.dart';

class AppRouter {
  static const String home = '/';

  static const String splashName = 'splash';
  static const String splashRoute = '/splash';
  static const String loginName = 'login';
  static const String loginRoute = '/login';
  static const String detailsName = 'details';
  static const String detailsRoute = 'details';

  static final router = GoRouter(
    routes: [
      GoRoute(
        name: splashName,
        path: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: loginName,
        path: loginRoute,
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) async {
          final authController = context.read<AuthController>();
          if (authController.state.isAuthenticated) {
            return home;
          }
          return null;
        },
      ),
      GoRoute(
        name: home,
        path: home,
        builder: (context, state) => const HomePage(),
        redirect: (context, state) async {
          final authController = context.read<AuthController>();
          if (!authController.state.isAuthenticated) {
            return loginRoute;
          }
          return null;
        },
        routes: [
          GoRoute(
            name: detailsName,
            path: '$detailsRoute/:code',
            builder: (context, state) {
              final code = state.pathParameters['code'];
              return CountryDetailsPage(countryCode: code ?? '');
            },
          ),
        ],
      ),
    ],
    onException: (context, state, router) => router.goNamed(splashName),
  );
}
