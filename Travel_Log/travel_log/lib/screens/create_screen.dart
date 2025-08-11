import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_log/widgets/bottom_navbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required String address});
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int _currentIndex = 2;
  String? _selectedTripType;
  String _address = '';
  DateTime? _startDate;
  DateTime? _endDate;

  final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');
  File? _imageFile;
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      setState(() {
        _address = arguments as String;  
      });
    }
  }

  Future<void> _saveTripData() async {
    if (_selectedTripType != null && _startDate != null && _endDate != null) {
      try {
        
        final User? user = FirebaseAuth.instance.currentUser;
        final String userId = user?.uid ?? 'default_user_id'; 
        
        await FirebaseFirestore.instance.collection('users')
          .doc(userId) 
          .collection('trips')
          .add({
        'tripName': _tripNameController.text,
        'location': _address,
        'tripType': _selectedTripType,
        'startDate': _startDate,
        'endDate': _endDate,
        'notes': _notesController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

        if (kDebugMode) {
          print("Trip Data Saved Successfully!");
        }

  
        if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trip saved successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        }

        if(mounted){
          Navigator.pop(context);
        }
      
      } catch (e) {
        if (kDebugMode) {
          print("Error saving data: $e");
        }

  
        if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save trip data.'),
            duration: Duration(seconds: 2),
          ),
        );
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate({required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  final List<String> tripTypes = [
    'Adventure Trip',
    'Business Trip',
    'Solo Trip',
    'Friends Trip',
    'Nature Trip',
    'Couple Trip',
    'Winter Trip',
    'Summer Trip',
    'Leisure Trip',
    'Romantic Trip',
    'Family Trip',
    'Cultural Trip',
    'Other Trip'
  ];

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
      case 3:
        Navigator.pushNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    const textColorPrimary = Colors.black;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( 
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
                            'New Trip',
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
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile != null
                            ? Image.file(_imageFile!, fit: BoxFit.cover)
                            : Icon(Icons.camera_alt, size: 40, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                         controller: _tripNameController,  
                        decoration: InputDecoration(
                          hintText: 'Trip Name ',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 94, 130, 169)),
                          filled: true,
                          fillColor: Color(0xFFF0F2F5),
                          contentPadding: EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color(0xFF111418)),
                        obscureText: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: TextEditingController(text: _address), 
                        decoration: InputDecoration(
                          hintText: 'Location ',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 94, 130, 169)),
                          filled: true,
                          fillColor: Color(0xFFF0F2F5),
                          contentPadding: EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color(0xFF111418)),
                        obscureText: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTripType,
                            hint: TextField(
                              decoration: InputDecoration(
                                hintText: 'Trip Type',
                                hintStyle: TextStyle(
                                  color: const Color.fromARGB(255, 2, 1, 1),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            style: TextStyle(
                              color: Color.fromARGB(255, 94, 130, 169),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedTripType = newValue;
                              });
                            },
                            items: tripTypes.map<DropdownMenuItem<String>>((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                            dropdownColor: Colors.white, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _notesController,  
                         maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Notes ',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 94, 130, 169)),
                          filled: true,
                          fillColor: Color(0xFFF0F2F5),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text("Start Date",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 94, 130, 169),
                              )),
                          InkWell(
                            onTap: () => _selectDate(isStart: true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _startDate != null
                                        ? _dateFormatter.format(_startDate!)
                                        : "Select a date",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Icon(Icons.calendar_today, size: 18),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "End Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 94, 130, 169),
                            ),
                          ),
                          InkWell(
                            onTap: () => _selectDate(isStart: false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _endDate != null
                                        ? _dateFormatter.format(_endDate!)
                                        : "Select a date",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Icon(Icons.calendar_today, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0b79ee),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(color: Colors.white),
                        ),
                        onPressed: _saveTripData,   
                        child: Text('Save Trip'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          _onTap(index);
        },
      ),
    );
  }
}
