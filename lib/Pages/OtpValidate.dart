import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/AppConstants/AppString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpValidate extends StatefulWidget {
  @override
  _OtpValidateState createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.otpLable,
              style: TextStyle(
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            AppConstant.sizer(context: context, h: 0.03, w: 0.0),
            TextField(
              showCursor: false,
              keyboardType: TextInputType.phone,
              maxLength: 6,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              cursorColor: AppColors.greenColor,
              decoration: InputDecoration(
                counterText: '',
                hintText: '------',
                hintStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 36,
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w700),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 36.0,
                  fontSize: 22,
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
