import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.68.54:5000";
const apiUrl = "$baseUrl/api";

Future<http.Response> postRequest(String uri, {required String body}) =>
    http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
