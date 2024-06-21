import 'dart:convert';

import 'package:sonata/communication/configuration.dart';
import 'package:sonata/communication/result.dart';

import 'package:http/http.dart' as http;

const _authUrl = "$apiUrl/auth";

Future<Result<String>> loginRequest(String email, String password) async {
  final response = await http.post(
    Uri.parse("$_authUrl/login"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: jsonDecode(response.body)["access_token"]);
}
