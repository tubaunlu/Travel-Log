import 'package:flutter/material.dart';


class LearnmoreScreen extends StatelessWidget {
  const LearnmoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;
    const primaryColor = Color(0xFF0c92f2);
    const textColorPrimary = Color(0xFF111518);
    const textColorSecondary = Color(0xFF60798a);
    const cardBackground = Color(0xFFF0F3F5);

    Widget iconMap() {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.map_outlined, color: textColorPrimary, size: 24),
      );
    }

    Widget iconNote() {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.note_outlined, color: textColorPrimary, size: 24),
      );
    }

    Widget iconUsers() {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.group_outlined, color: textColorPrimary, size: 24),
      );
    }

    Widget featureItem(Widget icon, String title, String subtitle) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: textColorPrimary,
                  
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: textColorSecondary,
        
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.arrow_back, color: textColorPrimary),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColorPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Başlık
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Discover the World with Travel Log',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textColorPrimary,
                      height: 1.2,
                    ),
                  ),
                ),
               const SizedBox(height: 38),
                featureItem(
                  iconMap(),
                  'Map Integration',
                  'Visualize your journeys on an interactive map.',
                ),
                const SizedBox(height: 16),
               featureItem(
                  iconNote(),
                  'Travel Logging',
                  'Document your adventures with photos and notes.',
                ),
                const SizedBox(height: 16),
                featureItem(
                  iconUsers(),
                  'Social Sharing',
                  'Share your experiences with friends and family.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
