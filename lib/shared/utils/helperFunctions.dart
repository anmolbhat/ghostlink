import 'package:ciphat/shared/shared.dart';
class HelperFunctions {
  bool isLoggedIn = false;
  bool isNotFirstLaunch = false;

  HelperFunctions._privateConstructor();

  static final HelperFunctions _instance = HelperFunctions._privateConstructor();

  factory HelperFunctions() {
    return _instance;
  }

  checkUserLogin() async {
    await Storage.checkUserLoginStatus().then((value) {
      if (value == true) {
        isLoggedIn = true;
      }
      if(value == false){
        isLoggedIn = false;
      }
    });
  }
  checkFirstRun() async {
    await Storage.checkFirstRun().then((value) {
      if (value == true) {
        isNotFirstLaunch = true;
      }
    });
  }
  startHelp(){
    checkUserLogin();
    checkFirstRun();
  }


  String? validateName(String? value) {
    return isValidName(value)
        ? null : "Full Name Required";
  }
  //Validate Email
  String? validateEmail(String? value, bool isLoginFail, String loginFailText) {
    return isValidEmailExp(value)
        ? isLoginFail ? loginFailText : null
        : "Enter Valid Email Address";
  }
  //Validate Pass
  String? validatePass(String? value, bool isLoginFail, String loginFailText) {
    return isValidPasswordExp(value)
        ? isLoginFail ? loginFailText : null
        : "Password must be atleast 8 characters";
  }
}
