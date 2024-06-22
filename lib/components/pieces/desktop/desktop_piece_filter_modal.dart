import 'package:flutter/material.dart';
import 'package:sonata/components/pieces/filter/piece_filter_state.dart';
import 'package:sonata/components/pieces/filter/piece_instrument_filter.dart';
import 'package:sonata/components/pieces/filter/piece_tags_filter.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/models/tag.dart';

class DesktopPieceFilterModal extends StatefulWidget {
  const DesktopPieceFilterModal({
    super.key,
    required this.currentFilters,
    required this.tags,
  });

  final PieceFilter currentFilters;
  final List<Tag> tags;

  @override
  State<DesktopPieceFilterModal> createState() =>
      _DesktopPieceFilterModalState();
}

class _DesktopPieceFilterModalState extends State<DesktopPieceFilterModal> {
  late ValueNotifier<List<int>> stateNotifier;
  late ValueNotifier<List<Tag>> tagsNotifier;
  late ValueNotifier<String?> instrumentNotifier;

  @override
  void initState() {
    super.initState();
    stateNotifier =
        ValueNotifier<List<int>>(List.from(widget.currentFilters.states));
    tagsNotifier =
        ValueNotifier<List<Tag>>(List.from(widget.currentFilters.tags));
    instrumentNotifier =
        ValueNotifier<String?>(widget.currentFilters.instrument);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Filter Pieces")),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Tags",
              style: TextStyle(fontSize: 18),
            ),
            const Divider(),
            PieceTagsFilter(notifier: tagsNotifier, tags: widget.tags),
            const SizedBox(height: 16),
            const Text(
              "States",
              style: TextStyle(fontSize: 18),
            ),
            const Divider(),
            PieceFilterState(stateNotifier),
            const SizedBox(height: 16),
            const Text(
              "Instrument",
              style: TextStyle(fontSize: 18),
            ),
            const Divider(),
            PieceInstrumentFilter(notifier: instrumentNotifier),
          ],
        ),
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
        tags: tagsNotifier.value,
        states: stateNotifier.value,
        instrument: instrumentNotifier.value,
        attachmentType: null,
      );
}
