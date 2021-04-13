import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/AppConstants/AppString.dart';
import 'package:agrozon/Core/AuthBase.dart';
import 'package:agrozon/Pages/HomePage.dart';
import 'package:agrozon/Pages/OtpValidate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../AppConstants/AppColors.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phoneController = TextEditingController();
  Auth auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.32,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.greenColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppString.loginLable,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  AppConstant.sizer(context: context, h: 0.01, w: 0.0),
                  Text(
                    AppString.loginMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  AppConstant.sizer(context: context, h: 0.01, w: 0.0),
                  TextField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: phoneController,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: AppColors.whiteColor,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(10, 11, 0, 0),
                        child: Text(
                          ' +91 ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                  AppConstant.sizer(context: context, h: 0.01, w: 0.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String phoneNumber =
                            "+91" + phoneController.text.trim();
                        print(phoneNumber);
                        if (phoneNumber.length == 13) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpValidate(
                                phoneNumber: phoneNumber,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        AppString.submitBtn,
                        style: TextStyle(
                            color: AppColors.greenColor,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AppConstant.sizer(context: context, h: 0.03, w: 0.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () async {
                  UserCredential cred = await auth.signInWithGoogle();
                  if (cred.user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  } else {
                    SnackBar snackBar = SnackBar(
                        content:
                            Text('Something went wrong. Please Try again.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.google),
                    Text(
                      AppString.googleSigninBtn,
                      style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: AppColors.googleSigninBtnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            AppConstant.sizer(context: context, h: 0.03, w: 0.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.facebookF),
                    Text(
                      AppString.facebookSigninBtn,
                      style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: AppColors.fbSigninBtnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
