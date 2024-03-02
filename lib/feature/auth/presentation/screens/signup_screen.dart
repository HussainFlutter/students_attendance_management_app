import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custom_text_form_field.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../bloc/auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final key = GlobalKey<FormState>();
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
        child: Form(
          key: key,
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
                      controller: nameController,
                      hintText: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        } else if (value.length < 4) {
                          return "Name must be at least 4 letters long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFormField(
                      validator: (value) {
                        final regex =
                            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        } else if (!regex.hasMatch(value)) {
                          return "Enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      hintText: "Email",
                    ),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 letters long";
                        } else {
                          return null;
                        }
                      },
                      isPassword: true,
                      controller: passwordController,
                      hintText: "Password",
                    ),
                  ],
                ),
              ),
              CustomButton(
                  title: "Sign Up",
                  onTap: () {
                    if (key.currentState!.validate()) {
                      context.read<AuthBloc>().add(SignUpEvent(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          ));
                    }
                  }),
              0.05.sizeH(context),
              TextButton(
                child: const Text(
                  "Already have an account? Login!",
                  textScaler: TextScaler.linear(1.0),
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteConsts.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
