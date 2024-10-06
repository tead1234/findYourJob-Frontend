import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kwansang/data/models/result_response_dto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants.dart';

class KwansangApi {
  final dio = Dio();

  KwansangApi() {
    configureDio();
  }

  void configureDio() {
    dio.options.baseUrl = Constants.baseUrl;
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode));
    log(dio.options.baseUrl);
  }

  Future<dynamic> uploadUserProfileImage(
      String imgPath, Uint8List? imgBytes, String gender, bool agreeYn) async {
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    dio.options.headers.putIfAbsent(Headers.acceptHeader, ()=> "application/json");

    // FormData formData = kIsWeb?FormData.fromMap({
    //   "file": MultipartFile.fromBytes(imgBytes!,filename:imgPath.split('/').last,contentType: MediaType('image','jpeg'))
    // }):FormData.fromMap({
    //     "file": MultipartFile.fromFileSync(imgPath,contentType: MediaType('image', 'jpeg'))
    //   });

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(imgBytes!,filename:imgPath.split('/').last,contentType: MediaType('image','jpeg'))
    });

    log("uploadUserProfileImage Start");
    if (kDebugMode && agreeYn) {
      await Future.delayed(Duration(seconds: 5));
      return ResultResponseDto(
          "men",
          "doctor",
          "actor",
          "banker",
          "https://picsum.photos/id/64/200/200",
          "https://picsum.photos/id/275/200/200",
          "https://picsum.photos/id/364/200/200");
    }
    final response = await dio.post("/face_api/upload/",
        data: formData,
        queryParameters: {"gender": gender, "consent": agreeYn});
    log("uploadUserProfileImage response $response");

    return ResultResponseDto.fromJson(response.data['prediction']);
  }
}
