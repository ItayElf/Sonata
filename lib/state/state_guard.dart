import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/state/global_state.dart';
import 'package:sonata/state/initialize_state.dart';

class StateGuard extends StatelessWidget {
  const StateGuard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context, listen: false);
    if (state.initialized) return child;

    return FutureBuilder(
      future: initializeGlobalState(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return child;
        }
      },
    );
  }
}
