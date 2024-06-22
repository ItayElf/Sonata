import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';

class PieceFilter {
  const PieceFilter({
    required this.tags,
    required this.states,
    required this.instrument,
    required this.attachmentType,
  });

  final List<Tag> tags;
  final List<int> states;
  final String? instrument;
  final String? attachmentType;

  PieceFilter.empty()
      : tags = [],
        states = [],
        instrument = null,
        attachmentType = null;

  int get length =>
      tags.length +
      states.length +
      (instrument != null ? 1 : 0) +
      (attachmentType != null ? 1 : 0);

  bool filter(Piece piece) {
    if (tags.isNotEmpty) {
      for (Tag tag in tags) {
        if (!piece.tags.contains(tag)) return false;
      }
    }
    if (states.isNotEmpty && !states.contains(piece.state)) return false;

    if (instrument != null && instrument != piece.instrument) return false;
    if (attachmentType != null && attachmentType != piece.fileType) {
      return false;
    }
    return true;
  }
}
