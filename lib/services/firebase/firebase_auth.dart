import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_data.dart';

class FirebaseAuthentication{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Firebase Login Function
  Future login(String email, String password) async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .user!;
      if(user != null){
        //Update the User Data
        String name = await FirebaseDatabase(uId: user.uid).firebaseGetUserName();
        await FirebaseDatabase(uId: user.uid).saveUserData(name, email);
        return true;
      }
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  //Firebase SignUp Function
  Future signUp(String name, String email, String password) async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .user!;
      if(user != null){
        //Update the User Data
        await FirebaseDatabase(uId: user.uid).addUserData(name, email);
        return true;
      }
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

}