import 'dart:convert';

import 'package:sonata/models/tag.dart';

class Piece {
  const Piece({
    required this.id,
    required this.name,
    this.description,
    this.instrument,
    required this.state,
    required this.userId,
    required this.addedAt,
    this.fileId,
    this.fileType,
    required this.tags,
  });

  final String id;
  final String name;
  final String? description;
  final String? instrument;
  final int state;
  final String userId;
  final String addedAt;
  final String? fileId;
  final String? fileType;
  final List<Tag> tags;

  Piece copyWith({
    String? id,
    String? name,
    String? description,
    String? instrument,
    int? state,
    String? userId,
    String? addedAt,
    String? fileId,
    String? fileType,
    List<Tag>? tags,
  }) {
    return Piece(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      instrument: instrument ?? this.instrument,
      state: state ?? this.state,
      userId: userId ?? this.userId,
      addedAt: addedAt ?? this.addedAt,
      fileId: fileId ?? this.fileId,
      fileType: fileType ?? this.fileType,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'instrument': instrument,
      'state': state,
      'user_id': userId,
      'added_at': addedAt,
      'file_id': fileId,
      'file_type': fileType,
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory Piece.fromMap(Map<String, dynamic> map) {
    return Piece(
      id: map['id'] as String,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      instrument:
          map['instrument'] != null ? map['instrument'] as String : null,
      state: map['state'] as int,
      userId: map['user_id'] as String,
      addedAt: map['added_at'] as String,
      fileId: map['file_id'] != null ? map['file_id'] as String : null,
      fileType: map['file_type'] != null ? map['file_type'] as String : null,
      tags: List<Tag>.from(
        (map['tags']).map<Tag>(
          (x) => Tag.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Piece.fromJson(String source) =>
      Piece.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Piece(id: $id, name: $name, description: $description, instrument: $instrument, state: $state, userId: $userId, addedAt: $addedAt, fileId: $fileId, fileType: $fileType, tags: $tags)';
  }

  @override
  bool operator ==(covariant Piece other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.instrument == instrument &&
        other.state == state &&
        other.userId == userId &&
        other.addedAt == addedAt &&
        other.fileId == fileId &&
        other.fileType == fileType &&
        other.tags == tags;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        instrument.hashCode ^
        state.hashCode ^
        userId.hashCode ^
        addedAt.hashCode ^
        fileId.hashCode ^
        fileType.hashCode ^
        tags.hashCode;
  }
}
