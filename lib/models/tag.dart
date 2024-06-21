import 'dart:convert';

class Tag {
  const Tag({
    required this.id,
    required this.userId,
    required this.tag,
    required this.color,
  });

  final String id;
  final String userId;
  final String tag;
  final String color;

  Tag copyWith({
    String? id,
    String? userId,
    String? tag,
    String? color,
  }) {
    return Tag(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tag: tag ?? this.tag,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'tag': tag,
      'color': color,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      tag: map['tag'] as String,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) =>
      Tag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tag(id: $id, userId: $userId, tag: $tag, color: $color)';
  }

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.tag == tag &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ tag.hashCode ^ color.hashCode;
  }
}
