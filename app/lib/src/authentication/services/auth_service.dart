import '../../core/services/http_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract interface class AuthService {
  Future<LoginResponse> login(LoginRequest request);
}

class AuthServiceImpl implements AuthService {
  final HttpService service;

  AuthServiceImpl(this.service);

  // TODO: Uncomment this code when the real login API is available

  // Uri get _baseUri => Uri.https(
  //       Env.authHost.value,
  //       loginEndpoint,
  //     );

  // final String loginEndpoint = '/login';

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // TODO: Uncomment this code when the real login API is available

    // final result = await service.post(_baseUri, request);

    // if (result.error != null) {
    //   switch (result.error!.type) {
    //     case HttpErrorType.notFound:
    //     case HttpErrorType.badRequest:
    //     case HttpErrorType.unauthorized:
    //     case HttpErrorType.forbidden:
    //       return const LoginResponse(
    //         user: null,
    //         error: LoginErrorType.invalidCredentials,
    //         isSuccess: false,
    //       );
    //     case HttpErrorType.internalServerError:
    //       return const LoginResponse(
    //         user: null,
    //         error: LoginErrorType.serverError,
    //         isSuccess: false,
    //       );
    //     default:
    //       return const LoginResponse(
    //         user: null,
    //         error: LoginErrorType.unknown,
    //         isSuccess: false,
    //       );
    //   }
    // }

    // return LoginResponse(
    //   error: result.isSuccessful ? null : LoginErrorType.unknown,
    //   user: result.isSuccessful ? request.username : null,
    //   isSuccess: result.isSuccessful,
    // );

    await Future.delayed(const Duration(seconds: 2));

    if (request.username != 'admin' || request.password != 'admin') {
      return const LoginResponse(
        user: null,
        error: LoginErrorType.invalidCredentials,
        isSuccess: false,
      );
    }

    return LoginResponse(
      user: request.username,
      error: null,
      isSuccess: true,
    );
  }
}
