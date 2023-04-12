import 'package:dio/dio.dart';
import 'package:my_gallery/components/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Authorization': "Bearer $token",
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Authorization': "Bearer $token",
    };
    return await dio!.post(
      url,
      data: data,
    );
  }
}
