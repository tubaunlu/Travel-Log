import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_log/widgets/custom_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color titleColor = Color(0xFF111418);
  static const Color subtitleColor = Color(0xFF6B7280);
  String profileImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBYq3549xNdVSXilWmv-vKCYEtKNFk617plHSQ6B1O10mG1YWLqXV6WDF5FkQ9NcAohQouxbQBTOFyKyBRuAYxP5irRdEIYwWKx1WE-lxfgbUimJHDQ7zrAdE3BFpWufFZYqMQevRVJ1NCpMS7xTWUrk68sr_0Qtb5MCbuGvp7aq_YMOjyFxMW7Hex3gGny_Id3bBKD06fFBYUSiy_7kni6xyur8gIDG3x5a0M6Wpuiygmac0jX6CSxh73uSG6DRa6cOnZXKUE4jiUD';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = true;

  final List<String> prefsList = ['Solo', 'Couple', 'Family', 'Group'];
  final Set<String> selectedPrefs = {}; 

  
  Future<void> _loadProfileData() async {
    setState(() {
      _isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final userProfileRef =
            FirebaseFirestore.instance.collection('profiles').doc(currentUser.uid);
        final docSnapshot = await userProfileRef.get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          setState(() {
            _nameController.text = data?['name'] ?? '';
            _bioController.text = data?['biography'] ?? '';
            profileImage = data?['profileImage'] ?? profileImage;
            selectedPrefs.addAll(List<String>.from(data?['preferences'] ?? []));
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading profile data: $e');
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  
  Future<void> _updateProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final userProfileRef =
            FirebaseFirestore.instance.collection('profiles').doc(currentUser.uid);
        await userProfileRef.update({
          'name': _nameController.text,
          'biography': _bioController.text,
          'preferences': selectedPrefs.toList(), 
        });
  
        if (mounted) {
          setState(() {
            _isLoading = false;
            Navigator.pushReplacementNamed(context, '/settings');
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error updating profile: $e');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData(); 
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Create Profile",
      showBackButton: true,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo, color: titleColor, size: 24),
                            onPressed: () {
                              
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add a profile photo',
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Choose a photo to represent yourself',
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(color: Color(0xFF60748a)),
                          filled: true,
                          fillColor: const Color(0xFFF0F2F5),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Color(0xFF111418)),
                        obscureText: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _bioController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Biography',
                          hintStyle: const TextStyle(color: Color(0xFF60748a)),
                          filled: true,
                          fillColor: const Color(0xFFF0F2F5),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Color(0xFF111418)),
                        obscureText: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Travel Preferences',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 8,
                      children: prefsList.map((pref) {
                        return FilterChip(
                          label: Text(pref),
                          selected: selectedPrefs.contains(pref),
                          onSelected: (selected) {
                            setState(() {
                              selected ? selectedPrefs.add(pref) : selectedPrefs.remove(pref);
                            });
                          },
                          backgroundColor: Colors.grey.shade50,
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 55),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0c77f2),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Save Profile',
                          style: GoogleFonts.splineSans(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
