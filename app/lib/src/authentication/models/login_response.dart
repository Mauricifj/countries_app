class LoginResponse {
  final String? user;
  final LoginErrorType? error;
  final bool isSuccess;

  const LoginResponse({
    this.user,
    this.error,
    this.isSuccess = false,
  });

  LoginResponse copyWith({
    String? user,
    LoginErrorType? error,
    bool? isSuccess,
  }) {
    return LoginResponse(
      user: user ?? this.user,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

enum LoginErrorType {
  invalidCredentials,
  serverError,
  unknown;

  String get message {
    switch (this) {
      case LoginErrorType.invalidCredentials:
        return 'Invalid credentials';
      case LoginErrorType.serverError:
        return 'Server error';
      case LoginErrorType.unknown:
        return 'Unknown error';
    }
  }
}
