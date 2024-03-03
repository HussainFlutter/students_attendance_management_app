import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_loggedin_students_usecase.dart';

import '../../../../main_injection_container.dart';

class ViewLoggedInStudentsScreen extends StatefulWidget {
  const ViewLoggedInStudentsScreen({super.key});

  @override
  State<ViewLoggedInStudentsScreen> createState() =>
      _ViewLoggedInStudentsScreenState();
}

class _ViewLoggedInStudentsScreenState
    extends State<ViewLoggedInStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged in Students"),
      ),
      body: StreamBuilder(
        stream: sl<GetAllLoggedInStudentsUseCase>().call(),
        builder: (context, snapshot) {
          // Checking if the connection is active
          if (snapshot.connectionState == ConnectionState.active) {
            // then showing Logged in students
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Logged in Students yet"),
              );
            } else {
              final data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final indexData = data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 0.1.mediaW(context),
                        backgroundImage: indexData.profilePic == null ||
                                indexData.profilePic!.isEmpty
                            ? const AssetImage("assets/images/logo.jpg")
                                as ImageProvider<Object>?
                            : CachedNetworkImageProvider(indexData.profilePic!)
                                as ImageProvider<Object>?,
                      ),
                      title: Text(indexData.name!),
                      subtitle: Text(indexData.email!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Created At"),
                          Text(DateFormat("dd-MM-yyyy")
                              .format(indexData.createAt!)),
                        ],
                      ),
                    );
                  });
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
    );
  }
}
