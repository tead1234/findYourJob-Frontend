import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class KwansangApi {
  final dio = Dio();

  KwansangApi() {
    configureDio();
  }

  void configureDio() {
    dio.options.baseUrl = '172.0.0.1';
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
  }

  Future<dynamic> uploadUserProfileImage(
      String imgPath, Uint8List? imgBytes, String gender, bool agreeYn) async {
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromBytes(imgBytes!),
      "gender": gender,
      "consent": agreeYn
    });

    log("uploadUserProfileImage Start");
    final response = await dio.post("/requestKwansang", data: formData);
    log("uploadUserProfileImage response $response");
    return response.data;
  }
}