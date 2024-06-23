import 'package:flutter/material.dart';
import 'package:sonata/components/pieces/filter/piece_filter_state.dart';
import 'package:sonata/components/pieces/filter/piece_instrument_filter.dart';
import 'package:sonata/components/pieces/filter/piece_tags_filter.dart';
import 'package:sonata/models/piece_filter.dart';
import 'package:sonata/models/tag.dart';

class MobilePieceFilterModal extends StatefulWidget {
  const MobilePieceFilterModal({
    super.key,
    required this.currentFilters,
    required this.tags,
  });

  final PieceFilter currentFilters;
  final List<Tag> tags;

  @override
  State<MobilePieceFilterModal> createState() => _MobilePieceFilterModalState();
}

class _MobilePieceFilterModalState extends State<MobilePieceFilterModal> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
          title: const Text("Filter Pieces"),
          actions: [
            TextButton(
              onPressed: () => onAccept(context),
              child: const Icon(Icons.check),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              const Text(
                "Tags",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(),
              PieceTagsFilter(
                notifier: tagsNotifier,
                tags: widget.tags,
                offsetResults: -60,
              ),
              const SizedBox(height: 56),
              const Text(
                "States",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(),
              PieceFilterState(stateNotifier),
              const SizedBox(height: 56),
              const Text(
                "Instrument",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(),
              PieceInstrumentFilter(notifier: instrumentNotifier),
            ],
          ),
        ),
      ),
    );
  }

  void onAccept(BuildContext context) {
    Navigator.of(context).pop(currentFilter);
  }

  PieceFilter get currentFilter => PieceFilter(
        tags: tagsNotifier.value,
        states: stateNotifier.value,
        instrument: instrumentNotifier.value,
        attachmentType: null,
      );
}
