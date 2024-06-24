import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/piece.dart';

const _filesUrl = "$apiUrl/files";

Future<Result<Piece>> uploadLinkRequest(
  String pieceId,
  String link,
  String accessToken,
) async {
  final response = await postRequest(
    "$_filesUrl/upload_link",
    token: accessToken,
    body: jsonEncode({
      "id": pieceId,
      "link": link,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Piece.fromJson(response.body));
}
