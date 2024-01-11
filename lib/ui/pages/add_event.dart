import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sports/data/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_sports/ui/widgets/circle_button.dart';
import 'package:event_sports/ui/widgets/custom_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  EventModel? event; // Create an instance of EventModel

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prixController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: prixController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Event Date'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd MMM').format(pickedDate);
                      dateController.text = formattedDate;
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(
                        titleController.text,
                        dateController.text,
                        locationController.text,
                        descriptionController.text,
                        prixController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            icon: 'assets/images/ic_arrow_left.png',
            onTap: () => Navigator.pop(context),
          ),
          const Text(
            "Detail",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          CircleButton(icon: 'assets/images/log-out.png', onTap: signUserOut)
        ],
      );
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _submitForm(
    String title,
    String date,
    String location,
    String description,
    String prix,
  ) async {
    try {
      // Add event to Firestore
      await FirebaseFirestore.instance.collection('events').add({
        'title': title,
        'image':
            "https://firebasestorage.googleapis.com/v0/b/event-management-252b8.appspot.com/o/comment-organiser-un-evenement-sportif-astuces.jpeg?alt=media&token=0bcde165-a4fd-4837-b65e-996c81257ea0",
        'date': date,
        'location': location,
        'description': description,
        'prix': prix
      });

      print('Event added to Firebase');
      // You can navigate to another screen or perform additional actions here
    } catch (error) {
      print('Failed to add event to Firebase: $error');
    }
  }
}
