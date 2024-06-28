import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/components/pieces/desktop/desktop_piece_filter_modal.dart';
import 'package:sonata/components/pieces/desktop/desktop_piece_row.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/pages/pieces/piece_edit/desktop_piece_edit.dart';
import 'package:sonata/pages/pieces/pieces_page/desktop/desktop_pieces_table.dart';
import 'package:sonata/state/global_state.dart';
import 'package:sonata/state/state_guard.dart';

class DesktopPiecesPage extends StatelessWidget {
  const DesktopPiecesPage({
    super.key,
    required this.searchNotifier,
    required this.getFilteredPieces,
    required this.filterNotifier,
  });

  final ValueNotifier<String> searchNotifier;
  final ValueNotifier<PieceFilter> filterNotifier;
  final List<Piece> Function(Iterable<Piece> pieces) getFilteredPieces;

  @override
  Widget build(BuildContext context) {
    return StateGuard(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: getFloatingButton(context),
          body: Row(
            children: [
              const IntrinsicWidth(
                child: DesktopNavigationDrawer(
                  selectedIndex: 0,
                ),
              ),
              const VerticalDivider(thickness: 0, width: 0),
              Flexible(
                flex: 2,
                child: DesktopPiecesTable(
                  searchNotifier: searchNotifier,
                  filterNotifier: filterNotifier,
                  getFilteredPieces: getFilteredPieces,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton.extended(
        label: const Text(
          "New Piece",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) => DesktopPieceEdit(
              oldPiece: null,
              tags: Provider.of<GlobalState>(context, listen: false).tags,
            ),
          )
        },
        tooltip: "New Piece",
        icon: const Icon(Icons.add),
      ),
    );
  }
}
