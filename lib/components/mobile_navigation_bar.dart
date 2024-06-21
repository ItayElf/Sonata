import 'package:flutter/material.dart';

class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  static const routes = {
    "/label": Icons.library_music_outlined,
    "/tags": Icons.label_outline,
    "/home": Icons.home_outlined,
    "/statistics": Icons.leaderboard_outlined,
    "/settings": Icons.settings_outlined
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
          ),
        ],
      ),
      child: NavigationBar(
        onDestinationSelected: (index) {
          Navigator.of(context).pushNamed(routes.keys.elementAt(index));
        },
        indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
        selectedIndex: selectedIndex,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        destinations: routes.keys
            .map((key) => NavigationDestination(
                  icon: Icon(routes[key]),
                  selectedIcon: Icon(
                    routes[key],
                    color: Colors.white,
                  ),
                  label: "",
                ))
            .toList(),
      ),
    );
  }
}
