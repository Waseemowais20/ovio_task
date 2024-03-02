import 'package:dio/dio.dart';
import 'package:ovio_task/general_exports.dart';

class ApiRequest {
  ApiRequest({
    @required this.className,
    this.path,
    this.fullUrl,
    this.method = ApiMethods.get,
    this.header,
    this.body,
    this.queryParameters,
    this.formatResponse = false,
    this.withLoading = false,
    this.shouldShowMessage = true,
    this.shouldShowRequestDetails = true,
  });

  final String? path;
  final String? fullUrl;
  final ApiMethods method;
  final String? className;
  final Map<String, dynamic>? header;
  final bool withLoading;
  final bool formatResponse;
  final bool shouldShowMessage;
  final bool shouldShowRequestDetails;
  final dynamic body;
  final dynamic queryParameters;
  dynamic response;

  Future<Dio> _dio() async {
    return Dio(
      BaseOptions(
        headers: header,
        queryParameters: queryParameters,
      ),
    );
  }

  Future<void> request({
    Function()? beforeSend,
    Function(dynamic data, dynamic response)? onSuccess,
    Function(dynamic data, dynamic response, dynamic header)?
        onSuccessWithHeader,
    Function(dynamic error)? onError,
  }) async {
    final Dio dio = await _dio();

    try {
      if (withLoading) {
        startLoading();
      }
      switch (method) {
        case ApiMethods.get:
          response = await dio.get(
            fullUrl ?? baseUrl + path!,
          );
          break;
        case ApiMethods.post:
          response = await dio.post(
            baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.put:
          response = await dio.put(
            baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.delete:
          response = await dio.delete(
            baseUrl + path!,
            data: body,
          );
          break;
        case ApiMethods.patch:
          response = await dio.patch(
            fullUrl ?? (baseUrl + path!),
            data: body,
            queryParameters: queryParameters,
          );
          break;
      }

      if (withLoading) {
        dismissLoading();
      }

      if (onSuccess != null) {
        onSuccess(response.data, response.data);
      }
      if (onSuccessWithHeader != null) {
        onSuccessWithHeader(response.data, response.data, response.headers.map);
      }
    } on Exception catch (error) {
      dismissLoading();

      if (error is DioException) {
        final dynamic errorData = error.response?.data ??
            <String, dynamic>{
              'errors': <Map<String, String>>[
                <String, String>{'message': error.toString()}
              ]
            };
        if (onError != null) {
          onError(errorData);
        }
        if (error.response?.statusCode == 401) {
          SnackbarService.showSnackbar(message: 'Unauthorized');
        }
      }
    }
  }
}

enum ApiMethods {
  get,
  post,
  put,
  delete,
  patch,
}
