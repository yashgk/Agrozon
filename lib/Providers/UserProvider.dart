import 'package:agrozon/Model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  AppUser appUser;

  Future<User> getUser() async {
    if (appUser.user != null) {
      print(appUser.user.uid);
      return appUser.user;
    } else {
      return null;
    }
  }

  void setUser(User finaluser) {
    appUser.user = finaluser;
    notifyListeners();
  }

  void removeUser() {
    appUser.user = null;
  }
}
