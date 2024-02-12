import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sef_ass/common/buttons.dart';
import 'package:sef_ass/common/text_field.dart';
import 'package:sef_ass/models/announcement.dart';
import '../../constants/global_variables.dart';
import 'dart:io';

class MakeAnnouncementScreen extends StatefulWidget {
  const MakeAnnouncementScreen({super.key});
  static const String routeName = '/make-announcement';

  @override
  State<MakeAnnouncementScreen> createState() => _MakeAnnouncementScreenState();
}

class _MakeAnnouncementScreenState extends State<MakeAnnouncementScreen> {
  final announcementTextController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _uploadImageAndAnnouncement() async {
    final announcementText = announcementTextController.text.trim();
    if (_image == null || announcementText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image/type in details'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('announcement_images/${DateTime.now()}.jpg');
      await storageRef.putFile(_image!);

      // Get download URL of the uploaded image
      final imageUrl = await storageRef.getDownloadURL();

      final announcement = Announcement(
          details: announcementText,
          imageFile: _image,
          imageUrl: imageUrl,
          timestamp: DateTime.now());

      // Add announcement details to Firestore
      await FirebaseFirestore.instance.collection('Announcement').add(
            announcement.toMap(),
          );

      // Reset the form
      announcementTextController.clear();
      setState(() {
        _image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Announcement uploaded successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print('Error uploading image and announcement: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.primaryColor,
      appBar: AppBar(
        foregroundColor: GlobalVariables.primaryColor,
        backgroundColor: GlobalVariables.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: GlobalVariables.backgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back button is pressed
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Make Announcements",
                  style: TextStyle(
                    color: GlobalVariables.backgroundColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                MyTextField(
                  controller: announcementTextController,
                  hintText: 'Details...',
                  keyboardType: TextInputType.text,
                  maxLines: 11,
                  maxLength: 300,
                  isDescriptionBox: true,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _getImage,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: GlobalVariables.secondaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_image == null)
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Upload image',
                                style: TextStyle(
                                  color: GlobalVariables.backgroundColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          _image != null
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'Image uploaded: ${_image!.path}',
                                      style: TextStyle(
                                          color:
                                              GlobalVariables.backgroundColor,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.photo,
                                      size: 30,
                                      color: GlobalVariables.backgroundColor,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(onTap: _uploadImageAndAnnouncement, text: 'Publish')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
