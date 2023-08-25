import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_buddy_flutter/navigation/screens.dart';

class BottomNavbarScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavbarScaffold({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    if (index != navigationShell.currentIndex) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => _onTap(context, index),
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.search),
            icon: const Icon(Icons.search_outlined),
            label: Screens.search.name,
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.fitness_center),
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Workout',
          ),
        ],
      ),
    );
  }
}
