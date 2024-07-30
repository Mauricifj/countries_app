import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/storage_service.dart';
import 'states/auth_state.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  final StorageService _storage;

  AuthController({
    required AuthService authService,
    required StorageService storage,
  })  : _storage = storage,
        _authService = authService;

  AuthState _state = AuthState.initial();
  AuthState get state => _state;

  final String _usernameKey = StorageServiceKeys.username.value;

  void onUsernameChanged(String value) {
    _state = _state.copyWith(username: value);
  }

  void onPasswordChanged(String value) {
    _state = _state.copyWith(password: value);
  }

  String? validateUsername(String? _) {
    return _state.loginRequest.validateUsername;
  }

  String? validatePassword(String? _) {
    return _state.loginRequest.validatePassword;
  }

  Future<void> init() async {
    // Simulate a delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    final username = await _storage.read(_usernameKey);

    _state = _state.copyWith(
      isAuthenticated: username != null,
    );
    notifyListeners();
  }

  Future<void> login() async {
    if (!_state.loginRequest.isValid) {
      return;
    }

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _authService.login(state.loginRequest);
    final username = result.user;

    if (result.isSuccess && username != null) {
      await _storage.write(_usernameKey, username);
      _state = AuthState.initial().copyWith(isAuthenticated: true);
    }

    _state = _state.copyWith(
      isLoading: false,
      errorMessage: result.error?.message,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await _storage.remove(_usernameKey);

    _state = AuthState.initial();
    notifyListeners();
  }
}
