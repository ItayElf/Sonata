import 'package:flutter/material.dart';
import 'package:sonata/components/pieces/desktop_piece_tag.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece.dart';

class DesktopPieceRow extends DataRow {
  DesktopPieceRow(Piece piece) : super(cells: _getCells(piece));

  static List<DataCell> _getCells(Piece piece) => [
        DataCell(
          Row(
            children: [
              Text(
                getInstrumentEmoji(piece.instrument),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              Text(
                piece.name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        DataCell(Text(getStateString(piece.state))),
        DataCell(Text(getFormattedDate(piece.addedAt))),
        DataCell(
          SizedBox(
            height: 25,
            width: 400,
            child: piece.tags.isEmpty
                ? Container()
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => DesktopPieceTag(tag: piece.tags[i]),
                    separatorBuilder: (_, __) => const SizedBox(width: 4),
                    itemCount: piece.tags.length,
                  ),
          ),
        ),
      ];
}
