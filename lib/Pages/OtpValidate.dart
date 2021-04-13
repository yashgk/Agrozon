import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/AppConstants/AppString.dart';
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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String _verificationId;

  Future<void> signInWithPhone(BuildContext context) async {
    await firebaseAuth.verifyPhoneNumber(
      timeout: Duration(seconds: 15),
      phoneNumber: widget.phoneNumber,
      //on verification complete
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential cred =
            await firebaseAuth.signInWithCredential(credential);
        if (cred.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        SnackBar snackBar = SnackBar(content: Text('Invalid OTP'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verificationId, int resendToken) async {
        print("Code sent");
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        print("Auto retrival time out");
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  @override
  void initState() {
    signInWithPhone(context);
    super.initState();
  }

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
              controller: otpController,
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
              onPressed: () async {
                try {
                  UserCredential cred = await firebaseAuth.signInWithCredential(
                      PhoneAuthProvider.credential(
                          verificationId: _verificationId,
                          smsCode: otpController.text));

                  if (cred.user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  }
                } catch (e) {
                  print(e.toString());
                  SnackBar snackBar = SnackBar(content: Text('Invalid OTP'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
