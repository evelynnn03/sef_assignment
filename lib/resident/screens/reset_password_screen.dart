import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../common/buttons.dart';
import '../../common/text_field.dart';
import '../../constants/global_variables.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static const String routeName = '/reset_password';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future passwordReset() async {
    final email = emailTextController.text.trim();
    final newPassword = passwordTextController.text;
    final confirmPassword = confirmPasswordTextController.text;

    try {
      final resident = FirebaseFirestore.instance.collection('Resident');
      final user =
          await resident.where('Resident Email', isEqualTo: email).get();

      if (user.docs.isNotEmpty) {
        final userDoc = user.docs.first;
        final oldPassword = userDoc['Resident Password'];

        if (newPassword == confirmPassword) {
          if (newPassword == oldPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password same as old password'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            await FirebaseFirestore.instance
                .collection('Resident')
                .doc(userDoc.id)
                .update({'Resident Password': newPassword});

            emailTextController.clear();
            passwordTextController.clear();
            confirmPasswordTextController.clear();
            setState(() {});

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password not matched!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email invalid/not allowed to reset password.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error resetting password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        foregroundColor: backgroundColor,
        backgroundColor: Colors.transparent,
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
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: GlobalVariables.backgroundColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'New Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  maxLines: obscurePassword ? 1 : null,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Confirm Password',
                  obscureText: obscureConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  onTap: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  maxLines: obscureConfirmPassword ? 1 : null,
                ),
                const SizedBox(height: 30),
                MyButton(onTap: passwordReset, text: 'Reset'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
