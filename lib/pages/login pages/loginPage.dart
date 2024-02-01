import 'package:ciphat/pages/viewModels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../widgets/databox.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});



  @override
  Widget build(BuildContext context) {
    final formViewModel = Provider.of<LoginViewModel>(context);
    bool isLoading = formViewModel.isLoading;
    String? name = formViewModel.name;
    String? email = formViewModel.email;
    String? password = formViewModel.password;
    GlobalKey<FormState> _loginformKey = formViewModel.loginformKey;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        foregroundColor: Colors.grey[350],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/login_pageee.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        ),
        title: const Text(
          "Welcome ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: isLoading ? const Center(child: SpinKitFadingCircle(color: Colors.black38,size: 91,)) : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
        child: Form(
          key: _loginformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                  'CipHAT',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  )
              ),
              const SizedBox(height: 2),
              const Text(
                  "Choose any way to login",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                  )
              ),
              const SizedBox(height: 7,),
              SizedBox(
                height: 200,
                child: Image.asset("assets/llogin_page.jpg",
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                initialValue: email,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                ),
                onChanged: (value) => formViewModel.setEmail(value),
                validator: (value) => formViewModel.validateEmail(value),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: password,
                obscureText: true,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    )
                ),
                onChanged: (value) => formViewModel.setPassword(value),
                validator: (value) => formViewModel.validatePass(value),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 50,
                width: 125,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: () {
                      if(_loginformKey.currentState!.validate()){formViewModel.loginForm(context);}
                    },
                    child: const Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 20.00),)
                ),
              ),
              const SizedBox(height: 12,),
              Text.rich(TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Register Here",
                        style: const TextStyle(color: Colors.blueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            formViewModel.navigateToPage(context, "/signup");
                          })
                  ]
              ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
