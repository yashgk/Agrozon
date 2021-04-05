import 'package:flutter/material.dart';

class AppConstant {
  static Widget sizer({BuildContext context, double h, double w}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * h,
      width: MediaQuery.of(context).size.width * w,
    );
  }
}
