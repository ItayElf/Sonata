import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_filter_modal.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_tile.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/state/global_state.dart';

class MobilePiecesPage extends StatelessWidget {
  const MobilePiecesPage({
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MobileNavigationBar(selectedIndex: 0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pieces",
                style:
                    GoogleFonts.greatVibes(fontSize: 51, letterSpacing: -0.5),
              ),
              getSearchRow(),
              const SizedBox(height: 16),
              getListTable()
            ],
          ),
        ),
      ),
    );
  }

  Consumer<GlobalState> getListTable() {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return ValueListenableBuilder(
            valueListenable: searchNotifier,
            builder: (context, _, child) {
              return ValueListenableBuilder(
                valueListenable: filterNotifier,
                builder: (context, _, child) {
                  final pieces = getFilteredPieces(state.pieces);
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, i) => MobilePieceTile(piece: pieces[i]),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: pieces.length,
                    ),
                  );
                },
              );
            });
      },
    );
  }

  Widget getSearchRow() {
    return Row(
      children: [
        Expanded(
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
              child: const Icon(Icons.filter_alt_outlined),
            ),
          ),
        )
      ],
    );
  }

  Future onFilterClick(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MobilePieceFilterModal(
        currentFilters: filterNotifier.value,
        tags: Provider.of<GlobalState>(context, listen: false).tags,
      ),
    ));
    if (result != null) {
      filterNotifier.value = result;
    }
  }
}
