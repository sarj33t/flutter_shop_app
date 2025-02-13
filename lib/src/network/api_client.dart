import 'package:dio/dio.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ApiClient]
///
class ApiClient{
  ApiClient(this._dio);
  final Dio _dio;

  /// Get Api
  Future<Response<dynamic>> getApi(String path) async{
    return await _dio.get(path);
  }
}