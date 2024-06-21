import 'dart:convert';

import 'package:sonata/communication/base.dart';
import 'package:sonata/communication/result.dart';
import 'package:sonata/models/tag.dart';

const _tagsUrl = "$apiUrl/tags";

Future<Result<Tag>> editTagRequest(
  Tag oldTag,
  Tag newTag,
  String accessToken,
) async {
  final response = await postRequest(
    "$_tagsUrl/edit",
    token: accessToken,
    body: jsonEncode({
      "id": oldTag.id,
      "tag": newTag.tag,
      "color": newTag.color,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Tag.fromJson(response.body));
}

Future<Result<Tag>> addTagRequest(
  Tag tag,
  String accessToken,
) async {
  final response = await postRequest(
    "$_tagsUrl/add",
    token: accessToken,
    body: jsonEncode({
      "tag": tag.tag,
      "color": tag.color,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return Result(data: Tag.fromJson(response.body));
}

Future<Result<Null>> deleteTagRequest(Tag tag, String accessToken) async {
  final response = await postRequest(
    "$_tagsUrl/delete",
    token: accessToken,
    body: jsonEncode({
      "id": tag.id,
    }),
  );

  if (response.statusCode != 200) {
    return Result(error: response.body);
  }

  return const Result(data: null);
}
