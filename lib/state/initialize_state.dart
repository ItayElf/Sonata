import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonata/communication/auth.dart';
import 'package:sonata/state/global_state.dart';

Future initializeGlobalState(BuildContext context) async {
  final state = Provider.of<GlobalState>(context, listen: false);
  if (state.initialized) return;
  final preferences = await SharedPreferences.getInstance();
  final accessToken = preferences.getString("access_token");
  if (accessToken == null) {
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  } else {
    final userResult = await getCurrentUser(accessToken);
    if (userResult.isError) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    } else if (context.mounted) {
      Provider.of<GlobalState>(context, listen: false)
          .initialize(userResult.data!, accessToken);
    }
  }
}
