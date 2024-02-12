// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/buttons.dart';
import '../../common/text_field.dart';
import '../../constants/global_variables.dart';

class ResidentRegisterScreen extends StatefulWidget {
  const ResidentRegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/resident-register';

  @override
  State<ResidentRegisterScreen> createState() => _ResidentRegisterScreenState();
}

class _ResidentRegisterScreenState extends State<ResidentRegisterScreen> {
  final fullNameTextController = TextEditingController();
  final icNoTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final phoneNoTextController = TextEditingController();
  final unitNoTextController = TextEditingController();
  final carPlateTextController = TextEditingController();
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  Future registerResident(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Resident').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        if (document.data().containsKey('Unit No')) {
          String unitNo = document.data()['Unit No'];
          if (unitNoTextController.text.trim() == unitNo) {
            throw Exception('User with same unit no cannot be registered');
          }
        } else {
          throw Exception('Cannot query Unit No during registerResident');
        }
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());

//only one unit no can be assigned to one resident to avoid conflicts
      await FirebaseFirestore.instance.collection('Resident').add({
        "Car Plate": carPlateTextController.text.trim(),
        "Resident Email": emailTextController.text.trim(),
        "Resident Name": fullNameTextController.text.trim(),
        "Resident IC": icNoTextController.text.trim(),
        "Resident HP": phoneNoTextController.text.trim(),
        "Resident Password": passwordTextController.text.trim(),
        "Unit No": unitNoTextController.text.trim(),
        "Outstanding Amount (RM)": 0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Register a resident",
                    style: TextStyle(
                      color: GlobalVariables.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const Text(
                    "Key in resident details",
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
                  MyTextField(
                    controller: unitNoTextController,
                    hintText: 'Unit No',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.house_rounded,
                  ),

                  const SizedBox(height: 13),
                  MyTextField(
                    controller: carPlateTextController,
                    hintText: 'Car Plate',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.car_rental,
                  ),

                  //signin button
                  const SizedBox(height: 25),
                  MyButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Form is valid, perform the registration
                          registerResident(context);
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
