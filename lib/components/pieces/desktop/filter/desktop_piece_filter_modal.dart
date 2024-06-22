import 'package:flutter/material.dart';
import 'package:sonata/components/pieces/desktop/filter/piece_filter_state.dart';
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
          PieceFilterState(stateNotifier),
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
