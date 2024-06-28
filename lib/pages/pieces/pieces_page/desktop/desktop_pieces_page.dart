import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/pages/pieces/piece_edit/desktop_piece_edit.dart';
import 'package:sonata/pages/pieces/piece_page/desktop/desktop_piece_view.dart';
import 'package:sonata/pages/pieces/pieces_page/desktop/desktop_pieces_table.dart';
import 'package:sonata/state/global_state.dart';
import 'package:sonata/state/state_guard.dart';

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

  Piece? _selectedPiece;

  @override
  Widget build(BuildContext context) {
    return StateGuard(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: _FloatingButton(
            selectedPiece: _selectedPiece,
            onDelete: onClose,
          ),
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
                    _animationController.forward();
                    setState(() {
                      _selectedPiece = piece;
                    });
                  },
                ),
              ),
              Flexible(
                flex: _animation.value,
                child: Container(
                  child: _selectedPiece != null
                      ? DesktopPieceView(
                          pieceId: _selectedPiece!.id,
                          onClose: onClose,
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClose() {
    _animationController.reverse();
    setState(() {
      _selectedPiece = null;
    });
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    required this.selectedPiece,
    this.onDelete,
  });

  final Piece? selectedPiece;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        final oldPiece =
            state.pieces.where((e) => e.id == selectedPiece?.id).firstOrNull;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton.extended(
            label: Text(
              selectedPiece == null ? "New Piece" : "Edit Piece",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) => DesktopPieceEdit(
                  oldPiece: oldPiece,
                  tags: state.tags,
                  onDelete: onDelete,
                ),
              )
            },
            tooltip: "New Piece",
            icon: Icon(selectedPiece == null ? Icons.add : Icons.edit_outlined),
          ),
        );
      },
    );
  }
}
