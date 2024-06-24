import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/pieces.dart';
import 'package:sonata/components/future_elevated_button.dart';
import 'package:sonata/components/pieces/filter/piece_filter_state.dart';
import 'package:sonata/components/pieces/filter/piece_instrument_filter.dart';
import 'package:sonata/components/pieces/filter/piece_tags_filter.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/state/global_state.dart';

class MobilePieceEdit extends StatefulWidget {
  const MobilePieceEdit({
    super.key,
    required this.oldPiece,
    required this.tags,
  });

  final Piece? oldPiece;
  final List<Tag> tags;

  @override
  State<MobilePieceEdit> createState() => _MobilePieceEditState();
}

class _MobilePieceEditState extends State<MobilePieceEdit> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
          title: Text(widget.oldPiece == null ? "New Piece" : "Edit Piece"),
          actions: [
            TextButton(
              onPressed: () => onAccept(context),
              child: const Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.greatVibes(fontSize: 36),
                  decoration: const InputDecoration(
                    hintText: "Piece Name",
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 16,
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
                  offsetResults: -36,
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
                if (widget.oldPiece != null) ...[
                  const SizedBox(height: 48),
                  FutureElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                    ),
                    onPressed: () => onDelete(context),
                    child: Text(
                      "Delete Piece",
                      style: TextStyle(
                        color: Colors.red.shade700,
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
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

  Future onEdit(BuildContext context) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await editPieceRequest(
      widget.oldPiece!,
      currentPiece,
      state.token,
    );
    if (result.isError) {
      if (context.mounted) {
        onError(context, result.error!);
      }
    }
    state.editPiece(widget.oldPiece!, result.data!);
    if (context.mounted) Navigator.of(context).pop();
  }

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

  Future onDelete(BuildContext context) async {}

  void onError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
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
