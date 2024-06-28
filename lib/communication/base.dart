import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.173.173:5000";
const apiUrl = "$baseUrl/api";

Future<http.Response> postRequest(
  String uri, {
  required String body,
  String? token,
}) =>
    http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null) 'Authorization': "Bearer $token",
      },
      body: body,
    );

Future<http.Response> getRequest(String uri, {String? token}) => http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null) 'Authorization': "Bearer $token",
      },
    );
