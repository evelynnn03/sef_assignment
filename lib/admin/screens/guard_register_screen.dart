// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/buttons.dart';
import '../../common/text_field.dart';
import '../../constants/global_variables.dart';

class GuardRegisterScreen extends StatefulWidget {
  const GuardRegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/guard-register';

  @override
  State<GuardRegisterScreen> createState() => _GuardRegisterScreenState();
}

class _GuardRegisterScreenState extends State<GuardRegisterScreen> {
  final fullNameTextController = TextEditingController();
  final icNoTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final phoneNoTextController = TextEditingController();
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future registerGuard(BuildContext context) async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload an image'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('guard_images/${DateTime.now()}.jpg');
      await storageRef.putFile(_image!);

      // Get download URL of the uploaded image
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());

      await FirebaseFirestore.instance.collection('Guard').add({
        "Guard Email": emailTextController.text.trim(),
        "Guard Name": fullNameTextController.text.trim(),
        "Guard IC": icNoTextController.text.trim(),
        "Guard HP": phoneNoTextController.text.trim(),
        "Guard Password": passwordTextController.text.trim(),
        "Image Url": imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during registration: $e'),
          duration: Duration(seconds: 3),
        ),
      );
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
          icon: const Icon(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Register a guard",
                    style: TextStyle(
                      color: GlobalVariables.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const Text(
                    "Key in guard details",
                    style: TextStyle(
                      color: GlobalVariables.backgroundColor,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),
                  MyTextField(
                    controller: fullNameTextController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.person,
                  ),

                  const SizedBox(height: 13),
                  MyTextField(
                    controller: icNoTextController,
                    hintText: 'IC No',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.credit_card,
                  ),

                  const SizedBox(height: 13),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                  ),

                  const SizedBox(height: 13),
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    maxLines: obscurePassword ? 1 : null,
                  ),

                  const SizedBox(height: 13),
                  MyTextField(
                    controller: phoneNoTextController,
                    hintText: 'Phone No',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                  ),

                  const SizedBox(height: 13),

                  GestureDetector(
                    onTap: _getImage,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: GlobalVariables.secondaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_image == null)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
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
                                          horizontal: 10.0),
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
                                        horizontal: 10.0),
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

                  //signin button
                  const SizedBox(height: 25),
                  MyButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Form is valid, perform the registration
                          registerGuard(context);
                        }
                      },
                      text: 'Sign Up'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
