import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/components/pieces/desktop_piece_row.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
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
          body: Row(
            children: [
              const IntrinsicWidth(
                child: DesktopNavigationDrawer(
                  selectedIndex: 0,
                ),
              ),
              const VerticalDivider(thickness: 0, width: 0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(72, 48, 72, 0),
                  child: Column(children: [
                    Text(
                      "Pieces",
                      style: GoogleFonts.greatVibes(
                          fontSize: 89, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 8),
                    getSearchRow(),
                    const SizedBox(height: 16),
                    getTableWrapper(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<GlobalState> getTableWrapper() {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return ValueListenableBuilder(
            valueListenable: searchNotifier,
            builder: (context, _, child) {
              final pieces = getFilteredPieces(state.pieces);
              return ValueListenableBuilder(
                valueListenable: filterNotifier,
                builder: (context, _, child) => getPiecesTable(pieces),
              );
            });
      },
    );
  }

  Row getPiecesTable(List<Piece> pieces) {
    return Row(
      children: [
        Expanded(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("State")),
              DataColumn(label: Text("Date Added")),
              DataColumn(label: Text("Tags")),
            ],
            rows: pieces.map((e) => DesktopPieceRow(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget getSearchRow() {
    return Row(
      children: [
        Flexible(flex: 1, child: Container()),
        Flexible(
          flex: 2,
          child: TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              hintText: "Search",
            ),
            onChanged: (value) => searchNotifier.value = value,
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.filter_alt_outlined),
        ),
        Flexible(flex: 1, child: Container()),
      ],
    );
  }
}
