// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sef_ass/admin/model/announcement_model.dart';
// import 'package:sef_ass/common/buttons.dart';

// class AnnouncementForm extends StatefulWidget {
//   const AnnouncementForm({super.key});

//   @override
//   State<AnnouncementForm> createState() => _AnnouncementFormState();
// }

// class _AnnouncementFormState extends State<AnnouncementForm> {
//   late String title;
//   late String content;
//   late String? pickedImagePath;

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       pickedImagePath = pickedFile?.path;
//     });
//   }

//   void submitAnnouncement() {
//     final announcement = Announcement(
//         title: title, content: content, imageUrl: pickedImagePath ?? '');

//     FirebaseFirestore.instance.collection('Announcement').add({
//       'Announcement Title': announcement.title,
//       'Announcement Content': announcement.content,
//       'Image': announcement.imageUrl
//     });

//     setState(() {
//       title = '';
//       content = '';
//       pickedImagePath = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Title'),
//           onChanged: (value) => title = value,
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Content'),
//           onChanged: (value) => title = value,
//         ),
//         if (pickedImagePath != null)
//           Image.file(
//             File(pickedImagePath!),
//             height: 100,
//             width: 100,
//             fit: BoxFit.cover,
//           ),
//         MyButton(
//             onTap: () async {
//               pickImage();
//             },
//             text: 'Upload image'),
//         MyButton(
//             onTap: () async {
//               submitAnnouncement();
//             },
//             text: 'Publish'),
//       ],
//     );
//   }
// }
