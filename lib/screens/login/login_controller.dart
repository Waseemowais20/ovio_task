import 'dart:convert';
import 'package:dio/dio.dart';

import '../../general_exports.dart';

class LoginController extends GetxController {
  final Dio _dio = Dio();

  Future<void> getToken(String username, String password) async {
    startLoading();
    var bytes = utf8.encode('$username:$password');
    var credentials = base64.encode(bytes);

    var headers = {'Authorization': 'Basic $credentials'};

    try {
      var response = await _dio.get(
        'https://login.meteomatics.com/api/v1/token',
        options: Options(headers: headers),
      );

      dismissLoading();

      if (response.statusCode == 200) {
        await SecureStorageService().write(
          key: 'auth_token',
          value: response.data['access_token'],
        );

        SnackbarService.showSnackbar(
          message: 'Success login',
          backgroundColor: const Color(AppColors.green),
        );
        Get.offAllNamed(routeHome);
      } else {
        SnackbarService.showSnackbar(
          message: response.statusMessage ?? 'Request failed',
          backgroundColor: const Color(AppColors.green),
        );
      }
    } catch (error) {
      SnackbarService.showSnackbar(message: 'Error in Retrieving token');
      dismissLoading();
    }
  }
}
