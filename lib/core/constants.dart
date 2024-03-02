import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseConsts {
  static const user = "users";
}

class RouteConsts {
  static const home = "HomeScreen";
  static const splashScreen = "/";
  static const signUp = "SignUpScreen";
  static const login = "Login";
}

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

void customPrint({required String message}) {
  debugPrint("----------------------------------------------");
  debugPrint("------------Start of Print--------------------");
  debugPrint("----------------------------------------------");
  debugPrint(message);
  debugPrint("----------------------------------------------");
  debugPrint("------------End of Print----------------------");
  debugPrint("----------------------------------------------");
}

void toast({
  required String message,
  Color backGroundColor = Colors.red,
  Color textColor = Colors.white,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backGroundColor,
      textColor: textColor,
      fontSize: 16.0);
}
