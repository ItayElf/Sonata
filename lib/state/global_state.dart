import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sonata/models/full_user.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/models/user.dart';

class GlobalState extends ChangeNotifier {
  late User _user;
  late String _token;
  late List<Piece> _pieces;
  late List<Tag> _tags;

  User get user => _user;
  String get token => _token;
  UnmodifiableListView<Piece> get pieces => UnmodifiableListView(_pieces);
  UnmodifiableListView<Tag> get tags => UnmodifiableListView(_tags);

  void initialize(FullUser fullUser, String token) {
    _pieces = List.from(fullUser.pieces);
    _tags = List.from(fullUser.tags);
    _user = User(
      id: fullUser.id,
      name: fullUser.name,
      joinedAt: fullUser.joinedAt,
      profilePictureId: fullUser.profilePictureId,
    );
    _token = token;
    notifyListeners();
  }

  void editTag(Tag oldTag, Tag newTag) {
    _tags = _tags.map((e) => e.id == oldTag.id ? newTag : e).toList();
    notifyListeners();
  }

  void addTag(Tag newTag) {
    _tags.add(newTag);
    notifyListeners();
  }

  void deleteTag(Tag tag) {
    _tags.removeWhere((element) => element.id == tag.id);
    notifyListeners();
  }
}
