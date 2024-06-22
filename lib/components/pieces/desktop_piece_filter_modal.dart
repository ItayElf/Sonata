import 'package:flutter/material.dart';
import 'package:sonata/design/piece_strings.dart';
import 'package:sonata/models/piece_filter.dart';

class DesktopPieceFilterModal extends StatefulWidget {
  const DesktopPieceFilterModal({super.key, required this.currentFilters});

  final PieceFilter currentFilters;

  @override
  State<DesktopPieceFilterModal> createState() =>
      _DesktopPieceFilterModalState();
}

class _DesktopPieceFilterModalState extends State<DesktopPieceFilterModal> {
  late ValueNotifier<List<int>> stateNotifier;

  @override
  void initState() {
    super.initState();
    stateNotifier =
        ValueNotifier<List<int>>(List.from(widget.currentFilters.states));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Filter Pieces")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "States",
            style: TextStyle(fontSize: 18),
          ),
          const Divider(),
          _StateFilter(stateNotifier),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () => onAccept(context), child: const Text("Apply"))
      ],
    );
  }

  void onAccept(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(currentFilter);
  }

  PieceFilter get currentFilter => PieceFilter(
        tags: [],
        states: stateNotifier.value,
        instrument: null,
        attachmentType: null,
      );
}

class _StateFilter extends StatefulWidget {
  const _StateFilter(this.notifier);

  final ValueNotifier<List<int>> notifier;

  @override
  State<_StateFilter> createState() => __StateFilterState();
}

class __StateFilterState extends State<_StateFilter> {
  // final List<bool> isSelected = pieceStates.keys.map((e) => false).toList();
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(pieceStates.length,
        (index) => (widget.notifier.value.contains(index))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        // renderBorder: false,
        // fillColor: Colors.white,
        isSelected: List.generate(pieceStates.length,
            (index) => (widget.notifier.value.contains(index))).toList(),
        onPressed: (i) {
          setState(() {
            if (widget.notifier.value.contains(i)) {
              widget.notifier.value.remove(i);
            } else {
              widget.notifier.value.add(i);
            }
          });
        },
        children: pieceStates.values
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e),
                ))
            .toList());
  }
}
