import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 7, 94, 164)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Uncomment the following lines to add a background image
          // Image.asset(
          //   'assets/images/travel.png',
          //   width: double.infinity,
          //   height: double.infinity,
          //   fit: BoxFit.cover,
          // ),
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}