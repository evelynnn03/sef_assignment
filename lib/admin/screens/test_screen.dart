import '../../constants/global_variables.dart';
import 'package:flutter/material.dart';
import '../../common/buttons.dart';
import '../../common/text_field.dart';
import '../../resident/widgets/bottom_nav_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  // text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  

                  const SizedBox(height: 30),
                  //hello user
                  const Text(
                    "Welcome to\nLoco Residence",
                    style: TextStyle(color: GlobalVariables.darkPurple, fontWeight: FontWeight.bold, fontSize: 35),
                  ),

                  const Text(
                    "Login your account",
                    style: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontSize: 18),
                  ),

                  // email textfield
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  
                  // password textfield
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  //signin button
                  const SizedBox(height: 30),
                  MyButton(onTap: () {}, text: 'Log In'),

                  
                ],
              ),
            ),
          ),
        ),
      ),
    );                 
  }
}