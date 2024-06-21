import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';

class FullUser {
  const FullUser({
    required this.id,
    required this.name,
    required this.joinedAt,
    this.profilePictureId,
    required this.tags,
    required this.pieces,
  });

  final String id;
  final String name;
  final String joinedAt;
  final String? profilePictureId;

  final List<Tag> tags;
  final List<Piece> pieces;

  FullUser copyWith({
    String? id,
    String? name,
    String? joinedAt,
    String? profilePictureId,
    List<Tag>? tags,
    List<Piece>? pieces,
  }) {
    return FullUser(
      id: id ?? this.id,
      name: name ?? this.name,
      joinedAt: joinedAt ?? this.joinedAt,
      profilePictureId: profilePictureId ?? this.profilePictureId,
      tags: tags ?? this.tags,
      pieces: pieces ?? this.pieces,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'joined_at': joinedAt,
      'profile_picture_id': profilePictureId,
      'tags': tags.map((x) => x.toMap()).toList(),
      'pieces': pieces.map((x) => x.toMap()).toList(),
    };
  }

  factory FullUser.fromMap(Map<String, dynamic> map) {
    return FullUser(
      id: map['id'] as String,
      name: map['name'] as String,
      joinedAt: map['joined_at'] as String,
      profilePictureId: map['profile_picture_id'] != null
          ? map['profile_picture_id'] as String
          : null,
      tags: List<Tag>.from(
        (map['tags']).map<Tag>(
          (x) => Tag.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pieces: List<Piece>.from(
        (map['pieces']).map<Piece>(
          (x) => Piece.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FullUser.fromJson(String source) =>
      FullUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FullUser(id: $id, name: $name, joinedAt: $joinedAt, profilePictureId: $profilePictureId, tags: $tags, pieces: $pieces)';
  }

  @override
  bool operator ==(covariant FullUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.joinedAt == joinedAt &&
        other.profilePictureId == profilePictureId &&
        listEquals(other.tags, tags) &&
        listEquals(other.pieces, pieces);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        joinedAt.hashCode ^
        profilePictureId.hashCode ^
        tags.hashCode ^
        pieces.hashCode;
  }
}
