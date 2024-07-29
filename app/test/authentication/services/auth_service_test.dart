// TODO: Uncomment this code when the real login API is available

// import 'package:countries_app/src/authentication/models/login_request.dart';
// import 'package:countries_app/src/authentication/models/login_response.dart';
// import 'package:countries_app/src/authentication/services/auth_service.dart';
// import 'package:countries_app/src/common/models/http_error.dart';
// import 'package:countries_app/src/common/models/http_response.dart';
// import 'package:countries_app/src/common/services/http_service.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockHttpService extends Mock implements HttpService {}
// class FakeUri extends Fake implements Uri {}

// void main() {
//   group('AuthService', () {
//     late AuthService service;
//     late MockHttpService mockHttpService;

//     const username = 'test_username';
//     const password = 'test_password';

//     setUpAll(() {
//       registerFallbackValue(Uri());
//     });

//     setUp(() {
//       mockHttpService = MockHttpService();
//       service = AuthServiceImpl(mockHttpService);
//     });

//     test('login() should return success if credentials are correct', () async {
//       // Arrange
//       final request = LoginRequest(username: username, password: password);

//       when(
//         () => mockHttpService.post(
//           any(),
//           request,
//         ),
//       ).thenAnswer(
//         (_) async => HttpResponse(
//           isSuccessful: true,
//           data: null,
//           error: null,
//         ),
//       );

//       // Act
//       final result = await service.login(request);

//       // Assert
//       expect(result.isSuccess, true);
//       expect(result.user, username);
//       expect(result.error, null);
//     });

//     test('login() should return failure if credentials are incorrect',
//         () async {
//       // Arrange
//       final request = LoginRequest(username: username, password: password);

//       when(
//         () => mockHttpService.post(
//           any(),
//           request,
//         ),
//       ).thenAnswer(
//         (_) async => HttpResponse(
//           isSuccessful: false,
//           data: null,
//           error: HttpError(
//             message: 'Invalid credentials',
//             type: HttpErrorType.unauthorized,
//           ),
//         ),
//       );

//       // Act
//       final result = await service.login(request);

//       // Assert
//       expect(result.isSuccess, false);
//       expect(result.user, null);
//       expect(result.error, LoginErrorType.invalidCredentials);
//     });
//   });
// }
