import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/piece.dart';

const _piecesUrl = "$apiUrl/pieces";

Future<Result<Piece>> editPieceRequest(
  Piece oldPiece,
  Piece newPiece,
  String accessToken,
) async {
  final response = await postRequest(
    "$_piecesUrl/edit",
    token: accessToken,
    body: jsonEncode({
      "id": oldPiece.id,
      "name": newPiece.name,
      "description": newPiece.description,
      "instrument": newPiece.instrument,
      "state": newPiece.state,
      "tag_ids": newPiece.tags.map((e) => e.id).toList(),
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Piece.fromJson(response.body));
}

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

Future<Result<Null>> deletePieceRequest(Piece piece, String accessToken) async {
  final response = await postRequest(
    "$_piecesUrl/delete",
    token: accessToken,
    body: jsonEncode({
      "id": piece.id,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return const Result(data: null);
}
