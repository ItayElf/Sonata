import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/piece.dart';

const _piecesUrl = "$apiUrl/pieces";

Future<Result<Piece>> addPieceRequest(
  Piece piece,
  String accessToken,
) async {
  final response = await postRequest(
    "$_piecesUrl/add",
    token: accessToken,
    body: jsonEncode({
      "name": piece.name,
      "description": piece.description,
      "instrument": piece.instrument,
      "state": piece.state,
      "tag_ids": piece.tags.map((e) => e.id).toList(),
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Piece.fromJson(response.body));
}
