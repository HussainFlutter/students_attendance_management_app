import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../bloc/home_bloc.dart';

class WriteApplicationScreen extends StatefulWidget {
  final String name;
  final String email;
  final String uid;
  const WriteApplicationScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.email,
  });

  @override
  State<WriteApplicationScreen> createState() => _WriteApplicationScreenState();
}

class _WriteApplicationScreenState extends State<WriteApplicationScreen> {
  final key = GlobalKey<FormState>();
  final TextEditingController applicationController = TextEditingController();
  @override
  void dispose() {
    applicationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write Application"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.mediaW(context)),
            child: Column(
              children: [
                0.1.sizeH(context),
                TextFormField(
                  controller: applicationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Write Application";
                    }
                    if (value.length < 50) {
                      return "Application must be at least 50 letters long";
                    } else {
                      return null;
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    hintText: "Application",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
                0.05.sizeH(context),
                CustomButton(
                    title: "Send Application",
                    onTap: () {
                      if (key.currentState!.validate()) {
                        context.read<HomeBloc>().add(SendApplicationEvent(
                              uid: widget.uid,
                              email: widget.email,
                              name: widget.name,
                              paragraph: applicationController.text,
                              context: context,
                            ));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
