import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/state/global_state.dart';

class MobileTagsPage extends StatelessWidget {
  const MobileTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, child) {
      return const Scaffold(
        bottomNavigationBar: MobileNavigationBar(selectedIndex: 1),
      );
    });
  }
}
