import 'package:flutter/material.dart';
import 'package:sonata/design/piece_strings.dart';

class PieceInstrumentFilter extends StatefulWidget {
  const PieceInstrumentFilter({super.key, required this.notifier});

  final ValueNotifier<String?> notifier;

  @override
  State<PieceInstrumentFilter> createState() => _PieceInstrumentFilterState();
}

class _PieceInstrumentFilterState extends State<PieceInstrumentFilter> {
  late String? value;

  @override
  void initState() {
    super.initState();
    value = widget.notifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      onChanged: (newValue) {
        setState(() {
          value = newValue;
          widget.notifier.value = value;
        });
      },
      items: pieceInstruments.keys
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text("${getInstrumentEmoji(e)} ${e ?? "Any"}"),
              ))
          .toList(),
    );
  }
}
