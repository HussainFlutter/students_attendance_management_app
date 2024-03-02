import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custom_text_form_field.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.1.sizeH(context),
            Image.asset(
              "assets/images/logo.jpg",
              scale: 0.003.mediaH(context),
            ),
            Text(
              "Students Attendance App",
              textScaler: TextScaler.linear(0.005.mediaW(context)),
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.1.mediaW(context),
                  vertical: 0.02.mediaH(context)),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Name",
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    controller: passwordController,
                    hintText: "Password",
                  ),
                ],
              ),
            ),
            CustomButton(title: "Sign Up", onTap: () {}),
            0.05.sizeH(context),
            TextButton(
              child: const Text(
                "Already have an account? Login!",
                textScaler: TextScaler.linear(1.0),
                style: TextStyle(),
              ),
              onPressed: () {
                //TODO: Navigate to Login screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
