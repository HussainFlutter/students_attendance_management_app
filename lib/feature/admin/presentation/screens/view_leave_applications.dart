import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_leave_applications_usecase.dart';

import '../../../../main_injection_container.dart';
import '../widgets/approve_and_disapprive_button.dart';

class ViewApplicationsScreen extends StatefulWidget {
  const ViewApplicationsScreen({super.key});

  @override
  State<ViewApplicationsScreen> createState() => _ViewApplicationsScreenState();
}

class _ViewApplicationsScreenState extends State<ViewApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Application"),
      ),
      body: StreamBuilder(
        stream: sl<GetAllLeaveApplicationsUseCase>().call(),
        builder: (context, snapshot) {
          // Checking if the connection is active
          if (snapshot.connectionState == ConnectionState.active) {
            // then showing Logged in students
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Applications yet"),
              );
            } else {
              final data = snapshot.data;
              return Column(
                children: [
                  Text("Total Leaves: ${data!.length} "),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final indexData = data[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${indexData.name}"),
                                Text("Email : ${indexData.email}"),
                                ReadMoreText(
                                  "Application:  ${indexData.paragraph} ",
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  lessStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                0.03.sizeH(context),
                                ApproveOrDisapprove(
                                  onApproveTap: () {},
                                  onDisapproveTap: () {},
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
                child: Text(
              "No internet connection",
              style: TextStyle(color: Colors.red),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child:
      //   Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Text("Name: Example"),
      //       const Text("Email : Example@gmail.com"),
      //       const ReadMoreText(
      //         "Application:  ",
      //         trimLines: 2,
      //         trimMode: TrimMode.Line,
      //         trimCollapsedText: 'Show more',
      //         trimExpandedText: 'Show less',
      //         moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      //         lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      //       ),
      //       ApproveOrDisapprove(
      //         onApproveTap: () {},
      //         onDisapproveTap: () {},
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
