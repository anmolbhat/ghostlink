import 'dart:async';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ciphat/models/models.dart';
import 'package:ciphat/services/services.dart';
import 'package:ciphat/shared/shared.dart';

class Message {
  final String text;
  final DateTime timestamp;

  Message({required this.text, required this.timestamp});
}
class MessageTest {
  final String text;
  final DateTime timestamp;
  final bool sentByMe;

  MessageTest({required this.text, required this.timestamp,required this.sentByMe});
}
//ChatViewModel
class ChatViewModel extends ChangeNotifier{

  ChatViewModel() {
    _init();
    listenToQuery();
  }

  Future<String> getChatName() async{return await Storage.checkAcitveChat(); notifyListeners();}
  Future<void> _init() async {person = await Storage.checkAcitveChat(); notifyListeners();}
  Future<void> saveChat() async {await Storage.saveList(person); await Storage.setAcitveChat(person); notifyListeners();}
  late List<Map<String, String>> messages = [
    {'message': 'Hit Refresh Manually'},
    {'message': 'Be a Man. DO IT YOURSELF!'}
  ];
  final List<Message> _dataList = [];

  List<Message> get dataList => _dataList;
  UserData user = UserData();
  String _message = '';
  String get message => _message;
  late List<Message> _sentList = [Message(text: "Welcome", timestamp: DateTime.now())];
  List<Message> get sentList => _sentList;
  late List<MessageTest> _fullList = [MessageTest(text: "Welcome", timestamp: DateTime.now(),sentByMe: true)];
  List<MessageTest> get fullList => _fullList;
  late List<Message> _receiveList = [Message(text: "Welcome", timestamp: DateTime.now())];
  List<Message> get receiveList => _receiveList;
  String person = '';

  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;


  final StreamController<List<DocumentSnapshot>> _snapshotController = StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get snapshotStream => _snapshotController.stream;

  final StreamController<List<DocumentSnapshot>> _snapshotControllerOne = StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get snapshotStreamOne => _snapshotControllerOne.stream;

  List<DocumentSnapshot> _documentSnapshots = [];
  List<DocumentSnapshot> get documentSnapshots => _documentSnapshots;

  List<DocumentSnapshot> _documentSnapshotsOne = [];
  List<DocumentSnapshot> get documentSnapshotsOne => _documentSnapshotsOne;

  void listenToQuery() async{
    if (user.id == "") {
      user = await Storage.getUserLoginData();
    } person = '';
    if(person == ''){person = await Storage.checkAcitveChat();}
    if (person != '') {
      Chats chats = Chats(senderId: person, receiverId: user.id);
      Chats chatsSent = Chats(senderId: user.id, receiverId: person);


      FirebaseFirestore.instance.collection('chats')
          .doc(chats.receiverId)
          .collection('messages')
          .doc(chats.senderId)
          .collection('received')
          .snapshots().listen((snapshot) {
        _documentSnapshots = snapshot.docs;
        _snapshotController.add(_documentSnapshots);
        parseSnaps(_documentSnapshots);
        notifyListeners();
      });

      FirebaseFirestore.instance.collection('chats')
          .doc(chatsSent.senderId)
          .collection('messages')
          .doc(chatsSent.receiverId)
          .collection('sent')
          .snapshots().listen((snapshot) {
        _documentSnapshotsOne = snapshot.docs;
        _snapshotControllerOne.add(_documentSnapshotsOne);
        parseSnapsOne(_documentSnapshotsOne);
        notifyListeners();
      });
    }
  }

  void parseSnaps(List<DocumentSnapshot> docsSnap){
    _sentList = [];
    for (var snapshot in docsSnap) {
      final text = snapshot.get('message') as String;
      final timestamp = DateTime.parse(snapshot.get('timestamp'));
      Message newMessage = Message(text: getDecryptedData(user.myPrivateRSAKey, text), timestamp: timestamp);
      _sentList.add(newMessage);
      print("calls to me");
    }
    //
    // Set<MessageTest> uniqueObjects = Set<MessageTest>.from(_fullList);
    // _fullList = uniqueObjects.toList();
    // sort();
    notifyListeners();
  }

  void parseSnapsOne(List<DocumentSnapshot> docsSnap){
    _receiveList = [];
    for (var snapshot in docsSnap) {
      final text = snapshot.get('message') as String;
      final timestamp = DateTime.parse(snapshot.get('timestamp'));
      Message newMessage = Message(text: getDecryptedData(user.myPrivateRSAKey, text), timestamp: timestamp);
      _receiveList.add(newMessage);
    }
    // Set<MessageTest> uniqueObjects = Set<MessageTest>.from(_fullList);
    // _fullList = uniqueObjects.toList();
    //
    notifyListeners();
  }

  void sort() async{
    _fullList = []; // Empty message list
    //Add both Sent and Receive to list
    for (var docs in _receiveList) {
      _fullList.add(MessageTest(text: docs.text, timestamp: docs.timestamp, sentByMe: true));
    }
    for (var docs in _sentList) {
      _fullList.add(MessageTest(text: docs.text, timestamp: docs.timestamp, sentByMe: false));
    }
    //Sort list
    _fullList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }


  void setPerson(String input){
    person = input;
    notifyListeners();
  }




  void getMessages() async {
    print('Init getMessage function');
    if (user.id == "") {
      user = await Storage.getUserLoginData();
    }
    if(person == ''){person = await Storage.checkAcitveChat();}

    if (person != '') {
      print('Refreshing Chats...Loading...');
      Chats chats = Chats(senderId: user.id, receiverId: person);
      QuerySnapshot? snap = await FirebaseDatabase(uId: user.id)
          .getMessage(chats);
      QuerySnapshot? snapSent = await FirebaseDatabase(uId: user.id)
          .getMessageSent(
          chats);
      if (snap != null) {
        QuerySnapshot snapshot = snap!;
        final sms = snapshot.docs.map((doc) =>
            Message(text: getDecryptedData(user.myPrivateRSAKey,doc['message']),
                timestamp: DateTime.parse(doc['timestamp']))).toList();
        _sentList = sms;
        notifyListeners();
      }
      else {
        print("Null at getMessage");
      }
      if (snapSent != null) {
        QuerySnapshot snapshot = snapSent!;
        final sms = snapshot.docs.map((doc) =>
            Message(text: getDecryptedData(user.myPrivateRSAKey,doc['message']),
                timestamp: DateTime.parse(doc['timestamp']))).toList();
        _receiveList = sms;
        notifyListeners();
      }
      else {
        print("Null at getMessage");
      }
    }
    listenToQuery();
  }


  void setMessage(String input){
    _message = input;
    notifyListeners();
  }


  Future sendMessage() async{
    if(user.id == ""){
      user = await Storage.getUserLoginData();
    }
    person = await Storage.checkAcitveChat();
    if(_message != '' && person != ''){

      DateTime now = DateTime.now();
      String pem = await FirebaseDatabase(uId: person).firebaseGetUserPublicKey();
      print('Person Public Key $pem');
      RSAPublicKey personPublicRSAKey = CryptoUtils.rsaPublicKeyFromPem(pem);

      String saveCopy = _message;

      _message = getEncryptedData(personPublicRSAKey, _message);
      Messages messages = Messages(timestamp: now.toString(), message: _message);

      saveCopy = getEncryptedData(user.myPublicRSAKey, saveCopy);
      Messages messagesSave = Messages(timestamp: now.toString(), message: saveCopy);

      Chats chats = Chats(senderId: user.id,receiverId: person);
      FirebaseDatabase(uId: user.id).sendMessage(chats, messages, messagesSave);

      _message = '';
      _controller.text = '';
      listenToQuery();
      notifyListeners();
    }
  }
}