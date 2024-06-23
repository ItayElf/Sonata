import 'package:flutter/material.dart';
import 'package:sonata/design/piece_strings.dart';

class PieceFilterState extends StatefulWidget {
  const PieceFilterState(this.notifier, {super.key, this.isUnique = false});

  final ValueNotifier<List<int>> notifier;
  final bool isUnique;

  @override
  State<PieceFilterState> createState() => _PieceFilterStateState();
}

class _PieceFilterStateState extends State<PieceFilterState> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(pieceStates.length,
        (index) => (widget.notifier.value.contains(index))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier,
      builder: (context, _, __) => ToggleButtons(
          isSelected: List.generate(pieceStates.length,
              (index) => (widget.notifier.value.contains(index))).toList(),
          onPressed: widget.isUnique ? uniqueOnPressed : onPressed,
          children: pieceStates.values
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e),
                  ))
              .toList()),
    );
  }

  void onPressed(int i) {
    setState(() {
      if (widget.notifier.value.contains(i)) {
        widget.notifier.value.remove(i);
      } else {
        widget.notifier.value.add(i);
      }
    });
  }

  void uniqueOnPressed(int i) {
    widget.notifier.value = [i];
  }
}
