import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/files.dart';
import 'package:sonata/components/future_elevated_button.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/state/global_state.dart';

class PieceAttachmentButtons extends StatelessWidget {
  const PieceAttachmentButtons({super.key, required this.piece});

  final Piece piece;

  @override
  Widget build(BuildContext context) {
    if (piece.fileType == null) {
      return Column(
        children: [
          FutureElevatedButton(
            onPressed: () => onUploadFile(context),
            child: const Text("Upload file"),
          ),
          const SizedBox(height: 24),
          FutureElevatedButton(
            onPressed: () => onUploadLink(context),
            child: const Text("Upload link"),
          ),
        ],
      );
    }
    return Column(children: [
      FutureElevatedButton(
        onPressed: () => onOpenAttachment(context),
        child: const Text("Open attachment"),
      ),
      const SizedBox(height: 24),
      FutureElevatedButton(
        onPressed: () => onRemoveAttachment(context),
        child: const Text("Remove attachment"),
      ),
    ]);
  }

  Future onUploadFile(BuildContext context) async {}

  Future onUploadLink(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => _LinkUploadDialog(piece: piece));
  }

  Future onOpenAttachment(BuildContext context) async {}

  Future onRemoveAttachment(BuildContext context) async {}
}

class _LinkUploadDialog extends StatefulWidget {
  const _LinkUploadDialog({
    required this.piece,
  });

  final Piece piece;

  @override
  State<_LinkUploadDialog> createState() => _LinkUploadDialogState();
}

class _LinkUploadDialogState extends State<_LinkUploadDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Upload link"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 48,
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter URL"),
        ),
      ),
      actions: [
        FutureElevatedButton(
          onPressed: () => onUpload(context),
          child: const Text("Upload"),
        )
      ],
    );
  }

  Future onUpload(BuildContext context) async {
    if (!controller.text.startsWith("http")) {
      return showError(context, "Link must start with 'http' or 'https'");
    }
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await uploadLinkRequest(
      widget.piece.id,
      controller.text,
      state.token,
    );
    if (result.isError) {
      if (context.mounted) {
        showError(context, result.error!);
      }
      return;
    }
    state.editPiece(widget.piece, result.data!);
    Navigator.of(context, rootNavigator: true).pop()
  }

  void showError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}
