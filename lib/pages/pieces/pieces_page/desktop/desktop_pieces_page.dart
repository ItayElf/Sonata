import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/components/pieces/desktop/desktop_piece_filter_modal.dart';
import 'package:sonata/components/pieces/desktop/desktop_piece_row.dart';
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
                    getSearchRow(context),
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
              return ValueListenableBuilder(
                valueListenable: filterNotifier,
                builder: (context, _, child) {
                  final pieces = getFilteredPieces(state.pieces);
                  return getPiecesTable(pieces);
                },
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

  Widget getSearchRow(BuildContext context) {
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
        ValueListenableBuilder(
          valueListenable: filterNotifier,
          builder: (context, _, __) => InkWell(
            onTap: () => onFilterClick(context),
            child: Badge(
              isLabelVisible: filterNotifier.value.length != 0,
              label: Text("${filterNotifier.value.length}"),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.filter_alt_outlined,
                size: 36,
              ),
            ),
          ),
        ),
        Flexible(flex: 1, child: Container()),
      ],
    );
  }

  Future onFilterClick(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => DesktopPieceFilterModal(
        currentFilters: filterNotifier.value,
        tags: Provider.of<GlobalState>(context, listen: false).tags,
      ),
    );
    if (result != null) {
      filterNotifier.value = result;
    }
  }
}
