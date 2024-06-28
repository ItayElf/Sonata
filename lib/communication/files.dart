import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/piece.dart';

const _filesUrl = "$apiUrl/files";
const fileViewUrl = "$apiUrl/files/file";

Future<String?> _getMimeType(File file) async {
  final bytes = await file.readAsBytes();
  final mimeType = lookupMimeType(file.path, headerBytes: bytes);
  return mimeType;
}

Future<Result<Piece>> uploadLinkRequest(
  String pieceId,
  String? link,
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

Future<Result<Piece>> uploadFileRequest(
  String pieceId,
  File file,
  String accessToken,
) async {
  final request =
      http.MultipartRequest("POST", Uri.parse("$_filesUrl/upload_file"));
  final contentType = MediaType.parse(await _getMimeType(file) ?? "");
  request.files.add(await http.MultipartFile.fromPath('file', file.path,
      contentType: contentType));
  request.fields["id"] = pieceId;
  request.headers["Authorization"] = "Bearer $accessToken";

  final response = await http.Response.fromStream(await request.send());

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Piece.fromJson(response.body));
}
