import 'package:ciphat/services/firebase/firebase_data.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared.dart';
class UserData {
  String? name = "";
  String? email = "";
  String? id = "";
  late RSAPublicKey myPublicRSAKey;
  late RSAPrivateKey myPrivateRSAKey ;
}
class Storage{
  Storage._privateConstructor();
  static final Storage _instance = Storage._privateConstructor();
  factory Storage(){
    return _instance;
  }

  static String userName = 'userName';
  static String userEmail = 'userEmail';
  static String userId = 'userId';
  static String myPublicRSAKey = 'publicKey';
  static String myPrivateRSAKey = 'privateKey';
  static String activeChat = 'chatId';
  static const _kKey = 'myChatList';
  static List<String> _list = [];

//Current Open Chat
  static Future<String> checkAcitveChat() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? activeChatId = prefs.getString(activeChat);
    if(activeChatId != null){return activeChatId;}
    else{return "";}
  }
  //Setting Current Chat
  static Future<bool> setAcitveChat(String input) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{await prefs.setString(activeChat,input); return true;}catch(e){print('Shared prefs Error: $e'); throw false;}
  }
//Get Chat List
  static Future<List<String>> getList() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kKey);
    return list ?? [];
  }
  //Delete Entry from Chat List
  static Future<bool> deleteList(String input) async{
    _list.remove(input);
    List<String> list = _list;
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_kKey, list);
      return true;
    }catch(e){throw false;}
  }

  //Chat List
  static Future<void> saveList(String input) async {
    _list = await getList();
    if(_list.contains(input)){return;}
    _list.add(input);
    List<String> list = _list;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kKey, list);
  }

  //Get Data
  static Future<UserData> getUserLoginData() async{
    UserData user = UserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('at get data Storage');
    print(prefs.getString(userEmail));
    print(prefs.getString(userName));
    print(prefs.getString(userId));

    user.name = prefs.getString(userName);
    user.email = prefs.getString(userEmail);
    user.id = prefs.getString(userId);
    user.myPrivateRSAKey = decodeRSAPrivateKeyFromPem(prefs.getString(myPrivateRSAKey)!);
    user.myPublicRSAKey = decodeRSAPublicKeyFromPem(prefs.getString(myPublicRSAKey)!);
    return user;
  }
  //RSA Key Pairs Save
  static Future<void>saveUserRSAKeys(String publicKey, String privateKey) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData user = UserData();
    user.id = prefs.getString(userId);
    try{
      await prefs.setString(myPrivateRSAKey, privateKey);
      await prefs.setString(myPublicRSAKey, publicKey);
      FirebaseDatabase(uId: user.id).updateFieldValue('publicKey', publicKey);
    }catch(e){throw "error $e";}
  }

  //Check Status
  static Future<bool?> checkUserLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(userEmail));
    return ((prefs.getString(userEmail) != "" && prefs.getString(userEmail) != null) ? true : false);
  }
  //Login Save
  static Future<bool?> userLoginStore(String name, String email, String password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      await prefs.setString(userName, name);
      await prefs.setString(userEmail, email);
      await prefs.setString(userId, password);
      print('print at usr login store');
      print(prefs.getString(userName));
      return true;
    }catch(e){return false;}
  }
  //LogOut Store
  static Future<bool?> userLogoutStore() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
    await prefs.setString(userName, "");
    await prefs.setString(userEmail, "");
    await prefs.setString(userId, "");
    return true;
    }catch(e){
      return false;
    }
  }
  //Splash Screen First Run Check
  static Future<bool?> checkFirstRun() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool('seen') ?? false);
  }
  static Future updateCheckFirstRun() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
  }
}