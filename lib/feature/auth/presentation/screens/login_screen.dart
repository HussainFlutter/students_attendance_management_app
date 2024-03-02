import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custom_text_form_field.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../bloc/auth_bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
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
            CustomButton(
                title: "Login",
                onTap: () {
                  context.read<AuthBloc>().add(LoginEvent(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      ));
                }),
            0.05.sizeH(context),
            TextButton(
              child: const Text(
                "Don't have an account? Sign Up!",
                textScaler: TextScaler.linear(1.0),
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteConsts.signUp);
              },
            ),
          ],
        ),
      ),
    );
  }
}
