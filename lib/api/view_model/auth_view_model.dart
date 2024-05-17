import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../model/user.dart';
import '../../utils/token_manager.dart';
import '../repository/auth_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel<User> {
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final token = await AuthRepository.login(email: email, password: password);
      await TokenManager.saveTokenAndRememberMe(token, true); // Assuming you want to remember the token
      setApiResponse(ApiResponse.completed(data: token));
    } catch (e, stackTrace) {
      log('Network error : $e');
      if (kDebugMode) print(stackTrace);
      setApiResponse(ApiResponse.error(message: e.toString()));
    }

    return apiResponse;
  }




}
