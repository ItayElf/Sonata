import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';

const _authUrl = "$apiUrl/auth";

Future<Result<String>> loginRequest(String email, String password) async {
  final response = await postRequest(
    "$_authUrl/login",
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
