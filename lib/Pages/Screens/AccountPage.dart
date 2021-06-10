import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/CommonWidgets/ProgressDialog.dart';
import 'package:agrozon/Core/AuthBase.dart';
import 'package:agrozon/Core/Prefs.dart';
import 'package:agrozon/Model/UserModel.dart';
import 'package:agrozon/Pages/LandingPage.dart';
import 'package:agrozon/Pages/Screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/CommonWidgets/CustomListTile.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ProgressDialog(text: 'please wait...')
        : Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.bgBlack),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: AppColors.transparent,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/plant.png',
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: -35,
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: Color(0xFFF5F6F9),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                  size: 15,
                                ),
                                shape: CircleBorder(),
                              )),
                        ],
                      ),
                      AppConstant.sizer(context: context, h: 0.0, w: 0.1),
                      Expanded(
                        child: Container(
                          child: Text(
                            user.fullName ?? "",
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                AppConstant.sizer(context: context, h: 0.03, w: 0.0),
                CustomListTile(
                  leading: Icons.person_outline,
                  title: 'Profile',
                  onListItemTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                AppConstant.sizer(context: context, w: 0.0, h: 0.01),
                CustomListTile(
                  leading: Icons.settings_outlined,
                  title: 'Settings',
                  onListItemTap: () {},
                ),
                AppConstant.sizer(context: context, w: 0.0, h: 0.01),
                ListTile(
                  tileColor: AppColors.bgWhite,
                  leading: Icon(
                    Icons.logout,
                    color: AppColors.secondaryColor,
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: () async {
                    bool canLogout = await Auth.signOut();
                    if (canLogout) {
                      Prefs.logOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()),
                          (route) => false);
                    }
                  },
                )
              ],
            ),
          );
  }
}
