import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/pages/pieces/piece_edit/desktop_piece_edit.dart';
import 'package:sonata/pages/pieces/pieces_page/desktop/desktop_pieces_table.dart';
import 'package:sonata/state/global_state.dart';

class DesktopPiecesPage extends StatefulWidget {
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
  State<DesktopPiecesPage> createState() => _DesktopPiecesPageState();
}

class _DesktopPiecesPageState extends State<DesktopPiecesPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), vsync: this);
  late final Animation _animation = IntTween(begin: 0, end: 50)
      .animate(_animationController)
    ..addListener(() => setState(() {}));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              flex: 100,
              child: DesktopPiecesTable(
                searchNotifier: widget.searchNotifier,
                filterNotifier: widget.filterNotifier,
                getFilteredPieces: widget.getFilteredPieces,
                onPieceClicked: (piece) {
                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                },
              ),
            ),
            Flexible(
              flex: _animation.value,
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
