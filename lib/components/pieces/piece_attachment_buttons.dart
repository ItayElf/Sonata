import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/files.dart';
import 'package:sonata/components/future_elevated_button.dart';
import 'package:sonata/models/piece.dart';
import 'package:sonata/state/global_state.dart';
import 'package:url_launcher/url_launcher.dart';

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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
        ),
        child: Text(
          "Remove attachment",
          style: TextStyle(color: Colors.red.shade700),
        ),
      ),
    ]);
  }

  Future onUploadFile(BuildContext context) async {
    final fileResult = await FilePicker.platform.pickFiles();

    if (fileResult == null) {
      return;
    }
    final file = File(fileResult.files.single.path!);
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await uploadFileRequest(
      piece.id,
      file,
      state.token,
    );
    if (result.isError) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.error!)));
      }
      return;
    }
    state.editPiece(piece, result.data!);
  }

  Future onUploadLink(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => _LinkUploadDialog(piece: piece));
  }

  Future onOpenAttachment(BuildContext context) async {
    if (piece.fileType?.startsWith("http") ?? false) {
      return await launchUrl(Uri.parse(piece.fileType!));
    }
  }

  Future onRemoveAttachment(BuildContext context) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await uploadLinkRequest(
      piece.id,
      null,
      state.token,
    );
    if (result.isError) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.error!)));
      }
      return;
    }
    state.editPiece(piece, result.data!);
  }
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
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
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
