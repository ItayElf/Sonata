import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/pieces.dart';
import 'package:sonata/components/pieces/filter/piece_filter_state.dart';
import 'package:sonata/components/pieces/filter/piece_instrument_filter.dart';
import 'package:sonata/components/pieces/filter/piece_tags_filter.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/state/global_state.dart';

class DesktopPieceEdit extends StatefulWidget {
  const DesktopPieceEdit({super.key, this.oldPiece, required this.tags});

  final Piece? oldPiece;
  final List<Tag> tags;

  @override
  State<DesktopPieceEdit> createState() => _DesktopPieceEditState();
}

class _DesktopPieceEditState extends State<DesktopPieceEdit> {
  late ValueNotifier<List<int>> stateNotifier;
  late ValueNotifier<List<Tag>> tagsNotifier;
  late ValueNotifier<String?> instrumentNotifier;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stateNotifier = ValueNotifier<List<int>>(
        widget.oldPiece != null ? [widget.oldPiece!.state] : [0]);
    tagsNotifier =
        ValueNotifier<List<Tag>>(List.from(widget.oldPiece?.tags ?? []));
    instrumentNotifier = ValueNotifier<String?>(widget.oldPiece?.instrument);
    nameController.text = widget.oldPiece?.name ?? "";
    descriptionController.text = widget.oldPiece?.description ?? "";
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(widget.oldPiece == null ? "New Piece" : "Edit Piece"),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                hintText: "Piece Name",
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextField(
              controller: descriptionController,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
            ),
            const SizedBox(height: 48),
            const Text(
              "Tags",
              style: TextStyle(fontSize: 18),
            ),
            PieceTagsFilter(
              notifier: tagsNotifier,
              tags: widget.tags,
              offsetResults: 0,
            ),
            const SizedBox(height: 48),
            const Text(
              "State",
              style: TextStyle(fontSize: 18),
            ),
            PieceFilterState(stateNotifier, isUnique: true),
            const SizedBox(height: 48),
            const Text(
              "Instrument",
              style: TextStyle(fontSize: 18),
            ),
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

  Future onAccept(BuildContext context) async {
    final error = validate();
    if (error != null) {
      onError(context, error);
      return;
    }
    if (widget.oldPiece == null) {
      onAdd(context);
    } else {
      onEdit(context);
    }
  }

  String? validate() {
    if (nameController.text.isEmpty) return "Name cannot be empty!";
    return null;
  }

  Future onEdit(BuildContext context) async {}

  Future onAdd(BuildContext context) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await addPieceRequest(currentPiece, state.token);
    if (result.isError) {
      if (context.mounted) {
        onError(context, result.error!);
      }
    }
    state.addPiece(result.data!);
    if (context.mounted) Navigator.of(context).pop();
  }

  void onError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(
          error,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }

  Piece get currentPiece => Piece(
        id: "",
        name: nameController.text,
        description: descriptionController.text.isEmpty
            ? null
            : descriptionController.text,
        instrument: instrumentNotifier.value,
        state: stateNotifier.value.first,
        userId: "",
        addedAt: DateTime.now(),
        fileId: null,
        fileType: null,
        tags: tagsNotifier.value,
      );
}
