import 'package:agrozon/Model/UserModel.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  AppUser _appUser;

  set userDetails(AppUser value) {
    _appUser = value;
    notifyListeners();
  }

  AppUser get fetchUserDetails => _appUser;
  AppUser getUser() {
    return _appUser;
  }
}
