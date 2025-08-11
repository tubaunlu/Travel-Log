import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_log/screens/profile_screen.dart';
import 'package:travel_log/screens/signin_screen.dart';
import 'package:travel_log/widgets/bottom_navbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 3;
  String name = 'Loading...'; 
  
  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/map');
        break;
      case 2:
        Navigator.pushNamed(context, '/create');
    }
  }

  final String profileImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBYq3549xNdVSXilWmv-vKCYEtKNFk617plHSQ6B1O10mG1YWLqXV6WDF5FkQ9NcAohQouxbQBTOFyKyBRuAYxP5irRdEIYwWKx1WE-lxfgbUimJHDQ7zrAdE3BFpWufFZYqMQevRVJ1NCpMS7xTWUrk68sr_0Qtb5MCbuGvp7aq_YMOjyFxMW7Hex3gGny_Id3bBKD06fFBYUSiy_7kni6xyur8gIDG3x5a0M6Wpuiygmac0jX6CSxh73uSG6DRa6cOnZXKUE4jiUD';

  final Color titleColor = const Color(0xFF111418);
  final Color subtitleColor = const Color(0xFF60748a);

  
  
  Future<void> _loadProfileData() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    try {
  
      final userProfileRef = FirebaseFirestore.instance.collection('profiles').doc(currentUser.uid);
      final docSnapshot = await userProfileRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          name = data?['name'] ?? 'No Name';  
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile data: $e');
      }
    }
  }
}

@override
void initState() {
  super.initState();
  _loadProfileData();  
}

  List<Map<String, dynamic>> getAccountItems(BuildContext context) {
    return [
      {
        'title': 'Profile',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
      {
        'title': 'Security',
        'onTap': () {
    
        }
      },
      {
        'title': 'Personal Information',
        'onTap': () {
        
        }
      },
      {
        'title': 'Preferences',
        'onTap': () {
          
        }
      },
      {
        'title': 'Notifications',
        'onTap': () {
      
        }
      },
      {
        'title': 'Privacy',
        'onTap': () {
        
        }
      },
      {
        'title': 'Log out',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      },
    ];
  }

  final List<Map<String, dynamic>> supportItems = [
    {
      'title': 'Help Center',
      'onTap': () {
    
      }
    },
    {
      'title': 'Contact Us',
      'onTap': () {
      
      }
    },
    {
      'title': 'Terms of Service',
      'onTap': () {
        
      }
    },
    {
      'title': 'Privacy Policy',
      'onTap': () {
  
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    const textColorPrimary = Color(0xFF111518);
    const backgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
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
                      'Settings',
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

        
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            name, 
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),

          
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account',
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),
                
                    ...getAccountItems(context).map((item) => ListTile(
                          title: Text(
                            item['title']!,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Color(0xFF111418)),
                          onTap: item['onTap'],
                        )),
                    const Divider(),

              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Support',
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),

        
                    ...supportItems.map((item) => ListTile(
                          title: Text(
                            item['title']!,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Color(0xFF111418)),
                          onTap: () {
                        
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _onTap(index);
        },
      ),
    );
  }
}
