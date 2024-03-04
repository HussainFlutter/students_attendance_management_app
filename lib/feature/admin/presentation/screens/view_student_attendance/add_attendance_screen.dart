import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custom_text_form_field.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../../bloc/admin_bloc.dart';

class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  final TextEditingController emailController = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Attendance"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.1.mediaW(context)),
        child: Center(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                0.1.sizeH(context),
                CustomButton(
                  title: "Add Attendance",
                  onTap: () {
                    if (key.currentState!.validate()) {
                      context.read<AdminBloc>().add(AddAttendanceEvent(
                            email: emailController.text.trim(),
                            attendance: true,
                          ));
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
