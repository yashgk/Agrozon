import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/AppConstants/AppString.dart';
import 'package:agrozon/Model/UserModel.dart';
import 'package:agrozon/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpValidate extends StatefulWidget {
  final String phoneNumber;
  OtpValidate({@required this.phoneNumber});
  @override
  _OtpValidateState createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth firebaseAuth;
  AppUser finaluser;
  Future<User> signInWithPhone(String phoneNumber, BuildContext context) async {
    firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.verifyPhoneNumber(
      timeout: Duration(seconds: 15),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verification success method ");
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        //finaluser.user = userCredential.user;
        print(userCredential.user.uid);
        if (userCredential.user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verification failed method ");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text('Verification Failed'),
                content: Text('Please try again...')));
      },
      codeSent: (String verificationId, int resendToken) async {
        print(verificationId);
        print("code sent method");
        // String code = otpController.text;
        // AuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: code);
        // UserCredential userCredential =
        //     await firebaseAuth.signInWithCredential(credential);
        // User user = userCredential.user;
        // if (user != null) {
        //   Navigator.pushReplacement(
        //       context, MaterialPageRoute(builder: (context) => HomePage()));
        // } else {
        //   showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //           title: Text('Verification Failed'),
        //           content: Text('Please try again...')));
        // }
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        print(verificationId);
        print("code auto retrieval timeout method");
        try {
          String code = otpController.text;

          AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: code);
          UserCredential userCredential =
              await firebaseAuth.signInWithCredential(credential);
          finaluser.user = userCredential.user;
        } catch (e) {
          print(e.toString());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    signInWithPhone(widget.phoneNumber, context);
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
            AppConstant.sizer(context: context, h: 0.02, w: 0.0),
            ElevatedButton(
              onPressed: () {
                if (finaluser.user.uid != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text('Verification Failed'),
                          content: Text('Please enter correct otp...')));
                }
              },
              child: Text(
                AppString.otpSubmitBtnText,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
