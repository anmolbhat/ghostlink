import 'package:ciphat/shared/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ciphat/models/models.dart';

class FirebaseDatabase{
  final String? uId;
  FirebaseDatabase({this.uId});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");


  Future sendMessage (Chats chat,Messages messages, Messages messagesSave) async{
    try{
      final CollectionReference messageSent = FirebaseFirestore.instance.collection('chats').doc(chat.receiverId).collection('messages').doc(chat.senderId).collection('recieved');
      final CollectionReference messageSentSaved = FirebaseFirestore.instance.collection('chats').doc(chat.senderId).collection('messages').doc(chat.receiverId).collection('sent');
      final messageSentSave = messageSent.doc(messages.timestamp);
      await messageSentSave.set(messages.toMap());
      final messageSentSavedSave = messageSentSaved.doc(messagesSave.timestamp);
      await messageSentSavedSave.set(messagesSave .toMap());
      print("Success Send Message");
    }catch(e){
      print('Send Message Function : $e');
    }
  }

  Future<QuerySnapshot?> getMessage(Chats chat) async{
    try{
      final CollectionReference messageSent = FirebaseFirestore.instance.collection('chats').doc(chat.senderId).collection('messages').doc(chat.receiverId).collection('recieved');
      final QuerySnapshot messages = await messageSent.get();
      print("Success getMessage");
      return messages;
    } catch(e){
      print('getMessage function: $e');
    }
  }
  Future<QuerySnapshot?> getMessageSent(Chats chat) async{
    try{
      final CollectionReference messageSent = FirebaseFirestore.instance.collection('chats').doc(chat.senderId).collection('messages').doc(chat.receiverId).collection('sent');
      final QuerySnapshot messages = await messageSent.get();
      print("Success getMessage");
      return messages;
    } catch(e){
      print('getMessage function: $e');
    }
  }

  void updateFieldValue(String fieldName, dynamic newValue) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({fieldName: newValue})
        .then((_) => print('Field updated successfully!'))
        .catchError((error) => print('Failed to update field: $error'));
  }


  Future addUserDataToStorage(String name, String email, String password) async{
    bool? temp = await Storage.userLoginStore(name, email, uId!);
    return temp;
  }

  Future<String> firebaseGetUserName() async{
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get();
      if (snapshot.exists) {
        final String name = snapshot.get('name') as String;
        print(name);
        return name;
      } else {
        print('User not found');return "";
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return "";
    }
  }
  Future<String> firebaseGetUserPublicKey() async{
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get();
      if (snapshot.exists) {
        final String pkey = snapshot.get('publicKey') as String;
        print(pkey);
        return pkey;
      } else {
        print('PublicKey not found');return "";
      }
    } catch (e) {
      print('Error fetching User Public Key: $e');
      return "";
    }
  }
  Future addUserDataToFirebase(Users user) async {
    try {
      await userCollection.add(user.toMap());
      print('User added successfully');
      return true;
    }
    catch (error) {
      print('Error adding user: $error');
      return false;
    }
  }
  Future addUserData(String name, String email) async{
    String password = "";
    // bool addFirebaseSuccess = await addUserDataToFirebase(name, email);
    Users user = Users(name: name, email: email, groups: [], dp: "", uId: uId);
    bool addFirebaseSuccess = await addUserDataToFirebase(user);
    bool? addStorageSuccess = await addUserDataToStorage(name, email, password);
    if(addStorageSuccess != false && addFirebaseSuccess != false){return true;}
    return false;
  }

  Future saveUserData(String name, String email) async{
    String password = "";
    bool? addStorageSuccess = await addUserDataToStorage(name, email, password);
    if(addStorageSuccess != false){return true;}
    return false;
  }
}







// Future addUserDataToFirebase(String name, String email) async{
//   try{ await userCollection.doc(uId).set({
//     "name": name,
//     "email":email,
//     "groups": [],
//     "dp": "",
//     "uId": uId,
//   });
//   return true;
//   }catch(e){
//     return false;
//   }
// }