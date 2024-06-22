import 'package:flutter/material.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_tag.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece.dart';

class MobilePieceTile extends StatelessWidget {
  const MobilePieceTile({super.key, required this.piece});

  final Piece piece;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        title: Text(
          piece.name,
          style: const TextStyle(fontSize: 18),
        ),
        leading: Text(
          getInstrumentEmoji(piece.instrument),
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: ClipRect(
          child: Row(
            children: [
              if (piece.tags.isNotEmpty) getTags(),
              if (!piece.tags.isNotEmpty) Text(getStateString(piece.state)),
            ],
          ),
        ),
      ),
    );
  }

  Expanded getTags() {
    return Expanded(
      child: SizedBox(
        height: 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) => i == 0
              ? Text(getStateString(piece.state))
              : i == 1
                  ? const Text(" • ")
                  : MobilePieceTag(tag: piece.tags[i - 2]),
          separatorBuilder: (_, __) => const SizedBox(width: 4),
          itemCount: piece.tags.length + 2,
        ),
      ),
    );
  }
}
