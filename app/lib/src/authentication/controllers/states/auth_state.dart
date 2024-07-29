import '../../models/login_request.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;
  final LoginRequest loginRequest;


  const AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.errorMessage,
    required this.loginRequest,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
      errorMessage: null,
      loginRequest: LoginRequest(),
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? username,
    String? password,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      loginRequest: loginRequest.copyWith(
        username: username,
        password: password,
      ),
    );
  }
}
