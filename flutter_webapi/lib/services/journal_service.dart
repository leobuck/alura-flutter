import 'dart:convert';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const String url = "http://192.168.0.50:3000/";
  static const String resource = "learnhttp";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  register(String content) {
    client.post(
      Uri.parse(getUrl()),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"content": content}),
    );
  }

  Future<String> get() async {
    http.Response response = await client.get(
      Uri.parse(getUrl()),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    return response.body;
  }
}
