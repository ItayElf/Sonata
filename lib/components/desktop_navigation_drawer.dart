import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopNavigationDrawer extends StatelessWidget {
  const DesktopNavigationDrawer({super.key, required this.selectedIndex});

  final int selectedIndex;

  static const routes = {
    "/pieces": Icons.library_music_outlined,
    "/tags": Icons.label_outline,
    "/home": Icons.home_outlined,
    "/statistics": Icons.leaderboard_outlined,
    "/settings": Icons.settings_outlined
  };

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: true,
      elevation: 3,
      selectedIndex: selectedIndex,
      labelType: NavigationRailLabelType.none,
      indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      onDestinationSelected: (index) {
        if (index == selectedIndex) return;
        Navigator.of(context).pushNamed(routes.keys.elementAt(index));
      },
      leading: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Text(
          "Sonata",
          style: GoogleFonts.greatVibes(fontSize: 89, letterSpacing: -1.5),
        ),
      ),
      destinations: routes.keys
          .map((key) => NavigationRailDestination(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                icon: Icon(
                  routes[key],
                  size: 36,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                selectedIcon: Icon(
                  routes[key],
                  size: 36,
                  color: Colors.white,
                ),
                label: Text(
                  key.substring(1, 2).toUpperCase() + key.substring(2),
                  style: GoogleFonts.greatVibes(
                    fontSize: 42,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
