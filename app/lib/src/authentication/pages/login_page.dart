import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/app_router.dart';
import '../../core/style/spacings.dart';
import '../../core/widgets/loading_widget.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isPasswordObscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();
    final state = context.watch<AuthController>().state;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    const maxWidth = 600.0;

    return Scaffold(
      body: Padding(
        padding: Spacings.large.horizontalPadding,
        child: Form(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Countries App!',
                    style: textTheme.titleLarge,
                  ),
                  Spacings.small.verticalSpacing,
                  Text(
                    'Please login to continue',
                    style: textTheme.bodyMedium,
                  ),
                  Spacings.xxl.verticalSpacing,
                  TextFormField(
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.onUsernameChanged,
                    readOnly: state.isLoading,
                    validator: controller.validateUsername,
                    decoration: _buildUsernameFieldDecoration(),
                    textInputAction: TextInputAction.next,
                  ),
                  Spacings.medium.verticalSpacing,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _isPasswordObscured,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: controller.onPasswordChanged,
                    readOnly: state.isLoading,
                    validator: controller.validatePassword,
                    decoration: _buildPasswordFieldDecoration(),
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (_) {
                      return state.isLoading ? null : _handleLogin();
                    },
                  ),
                  Spacings.xxl.verticalSpacing,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      maximumSize: const Size(maxWidth, 70),
                      minimumSize: const Size(maxWidth, 70),
                    ),
                    onPressed: state.isLoading ? null : _handleLogin,
                    child: state.isLoading
                        ? const LoadingWidget()
                        : _buildLoginText(textTheme, colorScheme),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildLoginText(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      'LOGIN',
      style: textTheme.titleLarge?.copyWith(
        color: colorScheme.onPrimary,
      ),
    );
  }

  void _handleLogin() async {
    if (!_validateForm()) {
      return;
    }

    final controller = context.read<AuthController>();
    await controller.login();

    final isAuthenticated = controller.state.isAuthenticated;
    if (mounted && isAuthenticated) {
      context.goNamed(AppRouter.home);
    }

    final error = controller.state.errorMessage;
    if (mounted && error != null) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final textTheme = theme.textTheme;

      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            error,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onError),
          ),
          backgroundColor: colorScheme.error,
          showCloseIcon: true,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  InputDecoration _buildUsernameFieldDecoration() {
    return InputDecoration(
      contentPadding: Spacings.large.padding,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      hintText: 'Username',
    );
  }

  InputDecoration _buildPasswordFieldDecoration() {
    return InputDecoration(
      hintText: 'Password',
      contentPadding: Spacings.large.padding,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _isPasswordObscured = !_isPasswordObscured;
          });
        },
      ),
    );
  }
}
