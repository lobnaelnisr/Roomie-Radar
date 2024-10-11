import 'package:flutter/material.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/services/firebase/firebase_room_service.dart';
import 'package:roomie_radar/utils/app_colors.dart';

class AddRoomView extends StatefulWidget {
  const AddRoomView({super.key});

  @override
  _AddRoomViewState createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String location = '';
  String price = '';
  List<String> features = [];

  final FirebaseRoomService _roomService = FirebaseRoomService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Room'),
        backgroundColor: appPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Add Room Details',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: appPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Title', (value) => title = value),
                  const SizedBox(height: 10),
                  _buildTextField('Description', (value) => description = value),
                  const SizedBox(height: 10),
                  _buildTextField('Location', (value) => location = value),
                  const SizedBox(height: 10),
                  _buildTextField('Price', (value) => price = value),
                  const SizedBox(height: 10),
                  _buildFeaturesField(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _addRoom,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add Room',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      onSaved: (value) => onSaved(value ?? ''),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildFeaturesField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Features (comma-separated)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      onSaved: (value) {
        if (value != null) {
          features = value.split(',').map((e) => e.trim()).toList();
        }
      },
    );
  }

  void _addRoom() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final room = RoomModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        location: location,
        price: price,
        features: features,
      );

      _roomService.addRoom(room); // Call FirebaseRoomService to add the room
      Navigator.of(context).pop(); // Close the form after submission
    }
  }
}
