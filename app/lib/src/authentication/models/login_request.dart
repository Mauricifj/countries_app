import '../../core/models/http_body.dart';

class LoginRequest implements HttpBody {
  final String? username;
  final String? password;

  LoginRequest({
    this.username,
    this.password,
  });

  String? get validateUsername {
    if (username == null || username!.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? get validatePassword {
    if (password == null || password!.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  bool get isValid {
    return validateUsername == null && validatePassword == null;
  }

  LoginRequest copyWith({
    String? username,
    String? password,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRequest &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return username.hashCode ^ password.hashCode;
  }
}
