// // import 'dart:io';
// // import 'package:eventhub/common/widgets/appbar/appbar.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:firebase_database/firebase_database.dart';

// // class AddEventPage extends StatefulWidget {
// //   @override
// //   _AddEventPageState createState() => _AddEventPageState();
// // }

// // class _AddEventPageState extends State<AddEventPage> {
// //   final TextEditingController eventNameController = TextEditingController();
// //   final TextEditingController eventDateController = TextEditingController();
// //   final TextEditingController cityController = TextEditingController();
// //   final TextEditingController eventTypeController = TextEditingController();
// //   final TextEditingController participantsController = TextEditingController();
// //   final TextEditingController descriptionController = TextEditingController();
// //   final TextEditingController rulesController = TextEditingController();
// //   File? imageFile;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: TAppBar(showBackArrow: false, title: Text('New Event')),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 TextField(
// //                   controller: eventNameController,
// //                   decoration: InputDecoration(labelText: 'Event Name'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: eventDateController,
// //                   decoration: InputDecoration(labelText: 'Event Date'),
// //                   onTap: () async {
// //                     DateTime? pickedDate = await showDatePicker(
// //                       context: context,
// //                       initialDate: DateTime.now(),
// //                       firstDate: DateTime.now(),
// //                       lastDate: DateTime(2101),
// //                     );

// //                     if (pickedDate != null) {
// //                       eventDateController.text =
// //                           pickedDate.toLocal().toString();
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: cityController,
// //                   decoration: InputDecoration(labelText: 'City'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: eventTypeController,
// //                   decoration: InputDecoration(labelText: 'Event Type'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: participantsController,
// //                   decoration:
// //                       InputDecoration(labelText: 'Number of Participants'),
// //                   keyboardType: TextInputType.number,
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: descriptionController,
// //                   decoration: InputDecoration(labelText: 'Description'),
// //                   maxLines: 3,
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: rulesController,
// //                   decoration: InputDecoration(labelText: 'Rules'),
// //                   maxLines: 3,
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 // Add an icon button for image picking
// //                 IconButton(
// //                   icon: Icon(Icons.add_a_photo),
// //                   onPressed: () {
// //                     _pickImage();
// //                   },
// //                 ),
// //                 // Display selected image if available
// //                 imageFile != null
// //                     ? Image.file(
// //                         imageFile!,
// //                         height: 100,
// //                         width: 100,
// //                       )
// //                     : Container(),
// //                 SizedBox(height: 16.0),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     addEventToFirebase(
// //                       eventNameController.text,
// //                       eventDateController.text,
// //                       cityController.text,
// //                       eventTypeController.text,
// //                       int.parse(participantsController.text),
// //                       descriptionController.text,
// //                       rulesController.text,
// //                       imageFile,
// //                     );
// //                   },
// //                   child: Text('Add Event'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _pickImage() async {
// //     try {
// //       final ImagePicker imagePicker = ImagePicker();
// //       final XFile? image =
// //           await imagePicker.pickImage(source: ImageSource.gallery);

// //       if (image != null) {
// //         setState(() {
// //           imageFile = File(image.path);
// //         });
// //       }
// //     } catch (e) {
// //       print("Error selecting image: $e");
// //     }
// //   }

// //   void addEventToFirebase(
// //     String eventName,
// //     String eventDate,
// //     String city,
// //     String eventType,
// //     int participants,
// //     String description,
// //     String rules,
// //     File? image,
// //   ) async {
// //     try {
// //       // Add event to Firestore
// //       DocumentReference documentReference =
// //           await FirebaseFirestore.instance.collection('events').add({
// //         'name': eventName,
// //         'date': eventDate,
// //         'city': city,
// //         'type': eventType,
// //         'participants': participants,
// //         'description': description,
// //         'rules': rules,
// //       });

// //       // Upload image to Firebase Storage
// //       if (image != null) {
// //         Reference storageReference = FirebaseStorage.instance
// //             .ref()
// //             .child('event_images/${documentReference.id}');
// //         await storageReference.putFile(image);

// //         // Get the image URL
// //         String imageURL = await storageReference.getDownloadURL();

// //         // Update the Firestore document with the image URL
// //         await documentReference.update({'imageURL': imageURL});
// //       }

// //       print('Event added to Firebase');
// //       // You can navigate to another screen or perform additional actions here
// //     } catch (error) {
// //       print('Failed to add event to Firebase: $error');
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final CollectionReference eventsCollection =
//       FirebaseFirestore.instance.collection('events');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Event List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: eventsCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;

//               return ListTile(
//                 title: Text(data['eventName']),
//                 subtitle: Text(data['eventDate']),
//                 // Add more widgets to display other event details as needed
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
