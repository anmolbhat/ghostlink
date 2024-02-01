import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ciphat/shared/shared.dart';
import 'package:ciphat/routes/routes.dart';
import 'package:ciphat/services/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

import '../../models/chats.dart';
import '../../shared/utils/Crypto/Helper/CryptoUtils.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _myList = [];
  UserData user = UserData();
  String name = "";
  String email = "";
  String id = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadList();
    getUserLoginData();
  }
  Future<void> _loadList() async {
    final list = await Storage.getList();
    setState(() {
      _myList = list;
    });
  }
  void _handleDeleteList(int index) async {

    await Storage.deleteList(_myList[index]);
    setState(() {

    });
    print('Entered the list');
  }

  _handleItemTap(int index) async {
    // Handle tap event for the item at the specified index
    await Storage.setAcitveChat(_myList[index]);
    print('Tapped item: ${_myList[index]}');

  }

  getUserLoginData() async{
    user = await Storage.getUserLoginData();
    setState(() {
      name = user.name!;
      email = user.email!;
      id = user.id!;

      print('user id from home page ${user.id}');
      print(name);
    });
  }
  getUserData() async{
    String  namez;
    const String documentId = "tM3vUXuGvwTqjhglf45b9oIHKVI3";
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (snapshot.exists) {
        namez = snapshot.get('name') as String;
        print(namez);
      } else {
        return print('User not found');
      }
      // final documentSnapshot = await documentRef.get();
      //
      // if (documentSnapshot.exists) {
      //   final name = documentSnapshot.data()?['name'] as String;
      //   print(name);
      // } else {
      //   print("Denied"); // Document does not exist
      // }
    } catch (e) {
      print('Error fetching user name: $e');
      return null;
    }
    setState(() {
      name = namez;
      email = user.email!;
      id = user.id!;
      print('user id from home page $id');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(height: 90,),
            const Text(
                "SECURE HOME PAGE WELCOME",
              style: TextStyle(color: Colors.blueAccent,fontSize: 20,),
                ),

            Column(
              children: [
                const Text("image"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name,style: const TextStyle(color: Colors.blue, fontSize: 20),),
                    Text(email,style: const TextStyle(color: Colors.black, fontSize: 10),)
                  ],
                ),
                Text(id,style: const TextStyle(color: Colors.red, fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 50,
              width: 125,
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: () async{
                      await Storage.userLogoutStore();
                      nextScreenReplace(context, "/login");
                    },
                    child: const Text("LogOut",style: TextStyle(color: Colors.white, fontSize: 20.00) ,)
                ),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                onPressed: () async{ getUserData();  },
                child: const Text("Get Data"),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                onPressed: () async{
                  DateTime now = DateTime.now();
                  String pem = await FirebaseDatabase(uId: 'ArSKfjdb2GcAkybWGO87IuLxNRh2').firebaseGetUserPublicKey();
                  final Chats chats = Chats(senderId: id, receiverId: "ArSKfjdb2GcAkybWGO87IuLxNRh2");
                  RSAPublicKey personPublicRSAKey = CryptoUtils.rsaPublicKeyFromPem(pem);
                  Messages messages = Messages(timestamp: now.toString(), message: getEncryptedData(personPublicRSAKey, "hello from Test 1"));

                  String saveCopy = "hello from Test 1";
                  saveCopy = getEncryptedData(user.myPublicRSAKey, saveCopy);

                  Messages messagesSave = Messages(timestamp: now.toString(), message: saveCopy);
                  FirebaseDatabase(uId: id).sendMessage(chats,messages,messagesSave);},
                child: const Text("Save Data"),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                onPressed: () {
                  nextScreenPush(context, '/chats');
                },
                child: const Text("Chat"),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                onPressed: () async{

                },
                child: const Text("Keys generation"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _myList.length,
                itemBuilder: (context, index) {
                  final item = _myList[index];
                  return ListTile(
                    title: Text(item),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _handleDeleteList(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: (){_handleItemTap(index);
                          nextScreenPush(context, '/chats');},
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
