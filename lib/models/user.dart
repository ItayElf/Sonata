import 'dart:convert';

class User {
  const User({
    required this.id,
    required this.name,
    required this.joinedAt,
    this.profilePictureId,
  });

  final String id;
  final String name;
  final String joinedAt;
  final String? profilePictureId;

  User copyWith({
    String? id,
    String? name,
    String? joinedAt,
    String? profilePictureId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      joinedAt: joinedAt ?? this.joinedAt,
      profilePictureId: profilePictureId ?? this.profilePictureId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'joined_at': joinedAt,
      'profile_picture_id': profilePictureId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      joinedAt: map['joined_at'] as String,
      profilePictureId: map['profile_picture_id'] != null
          ? map['profile_picture_id'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, joinedAt: $joinedAt, profilePictureId: $profilePictureId)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.joinedAt == joinedAt &&
        other.profilePictureId == profilePictureId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        joinedAt.hashCode ^
        profilePictureId.hashCode;
  }
}
