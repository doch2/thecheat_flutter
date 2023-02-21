library thecheat_flutter;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';

part 'models/fraud_search_response.dart';
part 'services/thecheat_fraud_search.dart';


final _dio = Dio();

const apiUrl = "https://api.thecheat.co.kr/api/v2";

late String? _apiKey;
late String? _encryptKey;

class TheCheatFlutterPlugin {
  initializeApp(String apiKey, String encryptKey) async {
    _apiKey = apiKey;
    _encryptKey = encryptKey;

    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = apiUrl;
        options.headers['X-TheCheat-ApiKey'] = _apiKey;

        return handler.next(options);
      },
    ));
  }
}