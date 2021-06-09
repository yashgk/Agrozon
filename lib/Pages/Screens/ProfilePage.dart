import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/CommonWidgets/ProgressDialog.dart';
import 'package:agrozon/Core/Sharef_Prefs.dart';
import 'package:agrozon/Model/UserModel.dart';
import 'package:agrozon/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditable = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AppUser user;
  bool isLoading = false;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    user = await Prefs.getUser();
    setState(() {
      nameController.text = user.fullName ?? "";
      mobileController.text = user.mobile ?? "";
      emailController.text = user.email ?? "";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.bgWhite,
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (isEditable == false) {
                      isEditable = true;
                    }
                  });
                },
                child: Icon(
                  Icons.edit,
                  color: AppColors.secondaryColor,
                ),
              ))
        ],
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios, color: AppColors.secondaryColor),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? ProgressDialog(text: "Please Wait ...")
          : Container(
              padding: EdgeInsets.all(15),
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.bgBlack,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Full Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      maxLength: 20,
                      enabled: isEditable,
                      controller: nameController,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      cursorColor: AppColors.secondaryColor,
                      decoration: InputDecoration(
                        counterText: '',
                        border: textFieldBorder,
                        disabledBorder: textFieldBorder,
                        enabledBorder: textFieldBorder,
                        focusedBorder: textFieldBorder,
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  AppConstant.sizer(context: context, h: 0.01, w: 0.0),
                  Text(
                    'Phone Number',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      maxLength: 20,
                      enabled: isEditable,
                      controller: mobileController,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      cursorColor: AppColors.secondaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(10, 11, 0, 0),
                          child: Text(
                            ' +91 ',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        counterText: '',
                        border: textFieldBorder,
                        disabledBorder: textFieldBorder,
                        enabledBorder: textFieldBorder,
                        focusedBorder: textFieldBorder,
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  AppConstant.sizer(context: context, h: 0.01, w: 0.0),
                  Text(
                    "E-mail",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      maxLength: 20,
                      enabled: isEditable,
                      controller: emailController,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      cursorColor: AppColors.secondaryColor,
                      decoration: InputDecoration(
                        counterText: '',
                        border: textFieldBorder,
                        disabledBorder: textFieldBorder,
                        enabledBorder: textFieldBorder,
                        focusedBorder: textFieldBorder,
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  AppConstant.sizer(context: context, h: 0.03, w: 0.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: AppColors.bgBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.secondaryColor,
                      elevation: 5.0,
                      shadowColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
