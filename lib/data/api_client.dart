import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inshorts_task/Core/Contants/app_strings.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiClient {
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() => _instance;

  late final Dio dio;

  DioApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: '${dotenv.env[AppStrings.baseUrl]}',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers[AppStrings.accept] = AppStrings.applicationJson;
          options.headers[AppStrings.authorization] = "Bearer ${dotenv.env[AppStrings.tmdbAccessToken]}";
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }
}

