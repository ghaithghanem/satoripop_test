



import '../../env.dart';
import '../../model/user.dart';
import '../../utils/token_manager.dart';
import '../../utils/user_session.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class AuthRepository {
  static const String apiUrl = '$baseUrl';

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/member/login",
      httpMethod: HttpMethod.post,
      body: {
        "email": email.toLowerCase().replaceAll(" ", ""),
        "password": password,
      },
      authIsRequired: false,
    );

    final token = json["token"];
    return token;
  }


  static Future<String> forgotPassword({required String email}) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/send-email",
      httpMethod: HttpMethod.post,
      body: {'email': email.toLowerCase().replaceAll(" ", "")},
      authIsRequired: false,
    );

    return json["data"]["token"];
  }

  static Future<bool> verifyResetPasswordToken({
    required String resetCode,
    required String token,
  }) async {
    await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/validate-token",
      httpMethod: HttpMethod.post,
      body: {
        'resetCode': resetCode,
        'token': token,
      },
      authIsRequired: false,
    );

    return true;
  }

  static Future<bool> resetPassword({
    required String token,
    required String plainPassword,
  }) async {
    await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/new-password",
      httpMethod: HttpMethod.post,
      body: {
        'token': token,
        'plainPassword': plainPassword,
      },
      authIsRequired: false,
    );

    return true;
  }
}