import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/components/pieces/mobile_piece_tile.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/state/global_state.dart';

class MobilePiecesPage extends StatefulWidget {
  const MobilePiecesPage({super.key});

  @override
  State<MobilePiecesPage> createState() => _MobilePiecesPageState();
}

class _MobilePiecesPageState extends State<MobilePiecesPage> {
  final ValueNotifier<String> _searchNotifier = ValueNotifier<String>('');

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
              getLayoutRow(),
              const SizedBox(height: 16),
              Consumer<GlobalState>(
                builder: (context, state, child) {
                  return ValueListenableBuilder(
                      valueListenable: _searchNotifier,
                      builder: (context, _, child) {
                        final pieces = getPieces(state.pieces);
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (_, i) =>
                                MobilePieceTile(piece: pieces[i]),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 20),
                            itemCount: pieces.length,
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Piece> getPieces(Iterable<Piece> pieces) {
    final newPieces = pieces
        .map((e) =>
            e.copyWith(tags: e.tags..sort((a, b) => a.tag.compareTo(b.tag))))
        .where((piece) => piece.name.contains(_searchNotifier.value))
        .toList();

    newPieces.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return newPieces;
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
            onChanged: (value) => _searchNotifier.value = value,
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.filter_alt_outlined),
        )
      ],
    );
  }

  Widget getLayoutRow() {
    return Row(
      children: [
        const Expanded(
            child: Text(
          "Results",
          style: TextStyle(fontSize: 16),
        )),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.grid_view_outlined),
        ),
      ],
    );
  }
}
