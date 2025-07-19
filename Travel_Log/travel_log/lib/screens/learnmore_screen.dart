import 'package:flutter/material.dart';

class LearnMoreScreen extends StatelessWidget {
  const LearnMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;
    // ignore: unused_local_variable
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
          
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Discover the World with Wanderlust',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textColorPrimary,
                      height: 1.2,
              
                    ),
                  ),
                ),
      
                featureItem(
                  iconMap(),
                  'Map Integration',
                  'Visualize your journeys on an interactive map.',
                ),
                featureItem(
                  iconNote(),
                  'Travel Logging',
                  'Document your adventures with photos and notes.',
                ),
                featureItem(
                  iconUsers(),
                  'Social Sharing',
                  'Share your experiences with friends and family.',
                ),
              ],
            ),
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                    onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
         )            ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
