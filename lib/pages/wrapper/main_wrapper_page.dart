import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_sync_frontend/services/navigation/router_constants.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  void _goBranch(String route) {
    context.goNamed(route);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _goBranch(RouteConstants.profile);
        break;
      case 1:
        _goBranch(RouteConstants.dashboard);
        break;
      case 2:
        _goBranch(RouteConstants.groups);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            // Profile
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: RouteConstants.profile),

            // Dashboard
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: RouteConstants.dashboard),
            // Groups
            BottomNavigationBarItem(
                icon: Icon(Icons.group), label: RouteConstants.groups),
          ]
      ),
    );
  }
}
