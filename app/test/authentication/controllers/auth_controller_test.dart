import 'package:countries_app/src/authentication/controllers/auth_controller.dart';
import 'package:countries_app/src/authentication/models/login_request.dart';
import 'package:countries_app/src/authentication/models/login_response.dart';
import 'package:countries_app/src/authentication/services/auth_service.dart';
import 'package:countries_app/src/authentication/services/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  group('AuthController', () {
    late AuthController controller;
    late MockAuthService mockAuthService;
    late MockStorageService mockStorageService;

    const username = 'test_username';
    const password = 'test_password';

    setUp(() {
      mockAuthService = MockAuthService();
      mockStorageService = MockStorageService();
      controller = AuthController(
        authService: mockAuthService,
        storage: mockStorageService,
      );
    });

    test(
        'init() should set isAuthenticated to true if username is found in storage',
        () async {
      // Arrange
      when(
        () => mockStorageService.read(StorageServiceKeys.username.value),
      ).thenAnswer(
        (_) async => username,
      );

      // Act
      await controller.init();

      // Assert
      expect(controller.state.isAuthenticated, true);
    });

    test(
        'init() should set isAuthenticated to false if username is not found in storage',
        () async {
      // Arrange
      when(
        () => mockStorageService.read(StorageServiceKeys.username.value),
      ).thenAnswer(
        (_) async => null,
      );

      // Act
      await controller.init();

      // Assert
      expect(controller.state.isAuthenticated, false);
    });

    test(
        'login() should call authService.login with correct username and password',
        () async {
      // Arrange
      final request = LoginRequest(username: username, password: password);

      when(
        () => mockAuthService.login(request),
      ).thenAnswer(
        (_) async => const LoginResponse(
          isSuccess: true,
          user: username,
          error: null,
        ),
      );

      when(
        () => mockStorageService.write(
          StorageServiceKeys.username.value,
          username,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      controller.onUsernameChanged(username);
      controller.onPasswordChanged(password);

      // Act
      await controller.login();

      // Assert
      verify(
        () => mockAuthService.login(request),
      ).called(1);
    });

    test(
        'login() should set isAuthenticated to true and store username in storage if login is successful',
        () async {
      // Arrange
      final request = LoginRequest(username: username, password: password);

      when(
        () => mockAuthService.login(request),
      ).thenAnswer(
        (_) async => const LoginResponse(
          isSuccess: true,
          user: username,
          error: null,
        ),
      );

      when(
        () => mockStorageService.write(
          StorageServiceKeys.username.value,
          username,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      controller.onUsernameChanged(username);
      controller.onPasswordChanged(password);

      // Act
      await controller.login();

      // Assert
      expect(controller.state.isAuthenticated, true);
      verify(
        () => mockStorageService.write(
          StorageServiceKeys.username.value,
          username,
        ),
      ).called(1);
    });

    test('login() should set isAuthenticated to false if login is unsuccessful',
        () async {
      // Arrange
      final request = LoginRequest(username: username, password: password);

      when(
        () => mockAuthService.login(request),
      ).thenAnswer(
        (_) async => const LoginResponse(
          isSuccess: false,
          user: null,
          error: LoginErrorType.invalidCredentials,
        ),
      );

      controller.onUsernameChanged(username);
      controller.onPasswordChanged(password);

      // Act
      await controller.login();

      // Assert
      expect(controller.state.isAuthenticated, false);
    });

    test(
        'logout() should remove username from storage and set isAuthenticated to false',
        () async {
      // Arrange
      when(
        () => mockStorageService.remove(StorageServiceKeys.username.value),
      ).thenAnswer(
        (_) async => true,
      );

      // Act
      await controller.logout();

      // Assert
      verify(
        () => mockStorageService.remove(StorageServiceKeys.username.value),
      ).called(1);
      expect(controller.state.isAuthenticated, false);
    });
  });
}
