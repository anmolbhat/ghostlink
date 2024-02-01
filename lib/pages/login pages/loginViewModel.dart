import 'package:ciphat/models/formmodel.dart';
import 'package:ciphat/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import '../../routes/navigation.dart';
import 'package:ciphat/services/services.dart';
import '../../shared/shared.dart';
import '../../widgets/databox.dart';
class LoginViewModel extends ChangeNotifier{
  //Variables
  final FormDataModel _formData = FormDataModel('','','');
  String? get name => _formData.name;
  String? get email => _formData.email;
  String? get password => _formData.password;
  final HelperFunctions _helperFunctions = HelperFunctions();
  final FirebaseAuthentication _firebaseAuthentication = FirebaseAuthentication();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginformKey => _loginformKey;
  final String loginFailText = "UserName or Password doesn't match ";
  bool isLoading = false;
  bool isLoginFail = false;

  //Updates Name
  void setName(String value) {
    if(isLoginFail){isLoginFail = false;}
    _formData.name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    if(isLoginFail){isLoginFail = false;}
    _formData.email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    if(isLoginFail){isLoginFail = false;}
    _formData.password = value;
    notifyListeners();
  }

  void navigateToPage(BuildContext context, page){
    nextScreenReplace(context, page);
  }

  String? validateName(String? value) {
    return _helperFunctions.validateName(value);
  }
  //Validate Email
  String? validateEmail(String? value) {
    return _helperFunctions.validateEmail(value, isLoginFail, loginFailText);
  }
  //Validate Pass
  String? validatePass(String? value) {
    return _helperFunctions.validatePass(value, isLoginFail, loginFailText);
  }
  //Submission of LoginForm
  void loginForm(BuildContext context) async{
    isLoading = true;
    notifyListeners();
    // Perform form submission or any other desired operations
    // You can access the form data using _formData
    print('Name: ${_formData.name}');
    print('Email: ${_formData.email}');
    print('PASS: ${_formData.password}');
    await _firebaseAuthentication.login(_formData.email,_formData.password)
        .then((value) async {
      if (value == true) {
        isLoading = false;
        RSAGeneration myKeyPairsGeneratorClass = RSAGeneration(email: _formData.email, password: _formData.password);
        myKeyPairsGeneratorClass.generateMyRSAKeyPairs();
        _formData.password = "";
        nextScreenReplace(context, "/homepage");
        print("Success");
      }
      else {
        isLoading = false;
        isLoginFail = true;
        notifyListeners();
        showDialogWithFields(context, value, "Wrong Email or Password");
        print("Fucked");
      }
    });
  }
}