import 'dart:async';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> getMethod(String url,
      {Map<String, String>? header}) async {
    http.Response response = await http.get(Uri.parse(url), headers: header);
    return response;
  }
}
