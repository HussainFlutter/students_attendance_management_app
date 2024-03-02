import 'package:flutter/cupertino.dart';

class FirebaseConsts {
  static const user = "users";
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
