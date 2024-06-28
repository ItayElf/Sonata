import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_tag.dart';
import 'package:sonata/components/pieces/piece_attachment_buttons.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/state/global_state.dart';

class DesktopPieceView extends StatelessWidget {
  const DesktopPieceView({super.key, required this.pieceId});

  final String pieceId;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, child) {
      final Piece? piece =
          state.pieces.where((e) => e.id == pieceId).firstOrNull;

      if (piece == null) {
        return Material(
          child: Center(
            child: Text("No piece with id $pieceId!"),
          ),
        );
      }

      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      piece.name,
                      style: GoogleFonts.greatVibes(fontSize: 56),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 24),
                  if (piece.description != null) ...[
                    Text(
                      piece.description!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (piece.tags.isNotEmpty) ...getTags(piece),
                  const SizedBox(height: 24),
                  getInfoLine(piece),
                  const SizedBox(height: 64),
                  Center(child: PieceAttachmentButtons(piece: piece)),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget getInfoLine(Piece piece) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
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
        Column(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date Added:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              getFormattedDate(piece.addedAt),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        )
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
            tags.map((e) => MobilePieceTag(tag: e, fontSize: 18)).toList(),
      ),
      const SizedBox(height: 24),
    ];
  }
}
