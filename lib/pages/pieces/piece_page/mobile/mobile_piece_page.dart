import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonata/components/pieces/mobile/mobile_piece_tag.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece.dart';

class MobilePiecePage extends StatelessWidget {
  const MobilePiecePage({super.key});

  @override
  Widget build(BuildContext context) {
    final piece = ModalRoute.of(context)!.settings.arguments as Piece;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.all(16),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                piece.name,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  piece.name,
                  style: GoogleFonts.greatVibes(fontSize: 36),
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
                if (piece.tags.isNotEmpty) ...[
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
                    children: piece.tags
                        .map((e) => MobilePieceTag(tag: e, fontSize: 16))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                Row(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
