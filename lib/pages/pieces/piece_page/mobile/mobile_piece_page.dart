import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_tag.dart';
import 'package:sonata/components/pieces/piece_attachment_buttons.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/pieces/piece_edit/mobile_piece_edit.dart';
import 'package:sonata/state/global_state.dart';

class MobilePiecePage extends StatelessWidget {
  const MobilePiecePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pieceId = ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
      child: Consumer<GlobalState>(
        builder: (context, state, child) {
          final Piece? piece =
              state.pieces.where((e) => e.id == pieceId).firstOrNull;

          if (piece == null) {
            return Material(
              child: Center(
                child: Text("No piece with id $pieceId!"),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: FittedBox(fit: BoxFit.fitWidth, child: Text(piece.name)),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton(
                onPressed: () => onEdit(context, piece, state.tags),
                child: const Icon(Icons.edit_outlined),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        piece.name,
                        style: GoogleFonts.greatVibes(fontSize: 36),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 24),
                    if (piece.description != null) ...[
                      Text(
                        piece.description!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (piece.tags.isNotEmpty) ...getTags(piece),
                    getInstrumentStateLine(piece),
                    const SizedBox(height: 64),
                    Center(child: PieceAttachmentButtons(piece: piece)),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onEdit(BuildContext context, Piece piece, List<Tag> tags) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MobilePieceEdit(oldPiece: piece, tags: tags),
      ),
    );
  }

  Row getInstrumentStateLine(Piece piece) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Instrument:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${getInstrumentEmoji(piece.instrument)} ${piece.instrument ?? "Any"}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "State:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                getStateString(piece.state),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getTags(Piece piece) {
    final tags = List.from(piece.tags);
    tags.sort((a, b) => a.tag.compareTo(b.tag));
    return [
      const Text(
        "Tags:",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        runSpacing: 4,
        spacing: 4,
        children:
            tags.map((e) => MobilePieceTag(tag: e, fontSize: 16)).toList(),
      ),
      const SizedBox(height: 24),
    ];
  }
}
