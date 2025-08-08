import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
   
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

     @override
   State<BottomNavBar> createState() => _BottomNavbarState();
}
   class _BottomNavbarState extends State<BottomNavBar>{
    @override
    Widget build(BuildContext context) {
      return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF111418),
      unselectedItemColor: Color(0xFF60748A),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
