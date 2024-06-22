import 'package:flutter/material.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/pages/pieces/pieces_page/desktop/desktop_pieces_page.dart';
import 'package:sonata/pages/pieces/pieces_page/mobile/mobile_pieces_page.dart';
import 'package:sonata/pages/responsive_page.dart';

class PiecesPage extends StatefulWidget {
  const PiecesPage({super.key});

  @override
  State<PiecesPage> createState() => _PiecesPageState();
}

class _PiecesPageState extends State<PiecesPage> {
  final searchNotifier = ValueNotifier("");
  final filterNotifier = ValueNotifier(PieceFilter.empty());

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      mobile: MobilePiecesPage(
        searchNotifier: searchNotifier,
        getFilteredPieces: getFilteredPieces,
        filterNotifier: filterNotifier,
      ),
      desktop: DesktopPiecesPage(
        searchNotifier: searchNotifier,
        getFilteredPieces: getFilteredPieces,
        filterNotifier: filterNotifier,
      ),
    );
  }

  List<Piece> getFilteredPieces(Iterable<Piece> pieces) {
    final newPieces = pieces
        .map((e) =>
            e.copyWith(tags: e.tags..sort((a, b) => a.tag.compareTo(b.tag))))
        .where((piece) => piece.name
            .toLowerCase()
            .contains(searchNotifier.value.toLowerCase()))
        .where(filterNotifier.value.filter)
        .toList();

    newPieces.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return newPieces;
  }
}
