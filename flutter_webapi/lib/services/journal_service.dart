import 'dart:convert';

import 'package:http/http.dart' as http;

class JournalService {
  static const String url = "http://192.168.0.50:3000/";
  static const String resource = "learnhttp";

  String getUrl() {
    return "$url$resource";
  }

  register(String content) {
    http.post(
      Uri.parse(getUrl()),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"content": content}),
    );
  }

  Future<String> get() async {
    http.Response response = await http.get(
      Uri.parse(getUrl()),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    return response.body;
  }
}
