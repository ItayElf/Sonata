import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/full_user.dart';

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

Future<Result<String>> registerRequest(
  String email,
  String username,
  String password,
) async {
  final response = await postRequest(
    "$_authUrl/register",
    body: jsonEncode({
      "email": email,
      "name": username,
      "password": password,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: jsonDecode(response.body)["access_token"]);
}

Future<Result<FullUser>> getCurrentUser(String accessToken) async {
  final response = await getRequest(
    "$_authUrl/current_user",
    token: accessToken,
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: FullUser.fromJson(response.body));
}
