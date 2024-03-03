import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Firebase Consts for collection names
class FirebaseConsts {
  static const user = "users";
  static const application = "applications";
  static const myAttendance = "my_attendance";
  static const attendance = "attendance";
}

class ImageConsts {
  static const logo = "assets/images/logo.jpg";
}

// Route consts for navigation
class RouteConsts {
  //Student only Screens
  static const home = "HomeScreen";
  static const viewMyAttendance = "View Attendance Screen";
  static const writeApplication = "Write Application Screen";
  //Admin Screens
  static const adminScreen = "Admin Screen";
  static const loggedInStudentsScreen = "Logged In Students Screen";
  static const viewApplications = "View Applications Screen";
  static const viewAllAttendance = "View All Attendance Screen";
  static const attendanceDetailsScreen = "Attendance Details Screen";
  static const editAttendanceScreen = "Edit Attendance Screen";
  static const addAttendanceScreen = "Add Attendance Screen";
  //Global Screens
  static const splashScreen = "/";
  static const signUp = "SignUpScreen";
  static const login = "Login Screen";
  static const profileScreen = "Profile Screen";
}

//Some extensions for MediaQuery and SizedBox
extension HeightSizedBox on double {
  Widget sizeH(BuildContext context) {
    return SizedBox(
      height: mediaH(context),
    );
  }
}

extension WidthSizedBox on double {
  Widget sizeW(BuildContext context) {
    return SizedBox(
      width: mediaW(context),
    );
  }
}

extension MediaHeight on double {
  double mediaH(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }
}

extension MediaWidth on double {
  double mediaW(BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}

//To check errors more clearly
void customPrint({required String message}) {
  debugPrint("----------------------------------------------");
  debugPrint("------------Start of Print--------------------");
  debugPrint("----------------------------------------------");
  debugPrint(message);
  debugPrint("----------------------------------------------");
  debugPrint("------------End of Print----------------------");
  debugPrint("----------------------------------------------");
}

//To display toast
void toast({
  required String message,
  Color backGroundColor = Colors.red,
  Color textColor = Colors.white,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backGroundColor,
      textColor: textColor,
      fontSize: 16.0);
}
