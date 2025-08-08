import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBackButton;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBackButton = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showBackButton
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        )
                      : const SizedBox(width: 48), 
                  Text(
                    title,
                    style: GoogleFonts.splineSans(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: Color(0xFF111418),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), 
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
