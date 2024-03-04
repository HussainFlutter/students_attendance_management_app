import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_management_app/core/constants.dart';

import '../../../z_global_widgets/custom_text_form_field.dart';
import '../../../z_global_widgets/custon_button.dart';
import '../bloc/admin_bloc.dart';

class SearchSpecificUser extends StatefulWidget {
  const SearchSpecificUser({super.key});

  @override
  State<SearchSpecificUser> createState() => _SearchSpecificUserState();
}

class _SearchSpecificUserState extends State<SearchSpecificUser> {
  final emailController = TextEditingController();
  final key = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Student"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.1.mediaW(context)),
          child: Center(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  0.15.sizeH(context),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("From date"),
                            Text(
                              startDate == null
                                  ? "0"
                                  : DateFormat("dd-MM-yyyy").format(startDate!),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("To date"),
                            Text(
                              endDate == null
                                  ? "0"
                                  : DateFormat("dd-MM-yyyy").format(endDate!),
                            ),
                          ],
                        ),
                      ]),
                  0.1.sizeH(context),
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
                    title: "Search Student",
                    onTap: () {
                      if (key.currentState!.validate()) {
                        if (endDate != null && startDate != null) {
                          context
                              .read<AdminBloc>()
                              .add(FromToDateStudentAttendanceEvent(
                                email: emailController.text,
                                fromDate: DateTime(startDate!.year,
                                    startDate!.month, startDate!.day - 1),
                                toDate: DateTime(endDate!.year, endDate!.month,
                                    endDate!.day + 1),
                              ));
                        } else {
                          toast(message: "Select dates");
                        }
                      }
                    },
                  ),
                  0.05.sizeH(context),
                  BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
                    if (state is AdminLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is AdminLoaded) {
                      final attendance = state.attendanceList;
                      if (attendance.isEmpty) {
                        return const Center(
                            child: Text("No Attendances of this Student yet"));
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: attendance.length,
                            itemBuilder: (context, index) {
                              final indexData = attendance[index];
                              return ListTile(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteConsts.attendanceDetailsScreen,
                                  arguments: indexData,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: indexData.attendance == false
                                      ? Colors.red
                                      : Colors.green,
                                  child: Text(
                                    indexData.attendance == false ? "A" : "P",
                                  ),
                                ),
                                title: Text(indexData.name!),
                                subtitle: Text(indexData.email!),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Marked At"),
                                    Text(DateFormat("dd-MM-yyyy")
                                        .format(indexData.markedAt!)),
                                  ],
                                ),
                              );
                            });
                      }
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDateRangePicker(
            context,
            dismissible: true,
            minimumDate: DateTime(2024),
            maximumDate: DateTime(2050),
            endDate: endDate,
            startDate: startDate,
            backgroundColor: Colors.white,
            primaryColor: Colors.green,
            onApplyClick: (start, end) {
              setState(() {
                startDate = start;
                endDate = end;
              });
            },
            onCancelClick: () {
              setState(() {
                endDate = null;
                startDate = null;
              });
            },
          );
        },
        tooltip: 'choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
    );
  }
}
