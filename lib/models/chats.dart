import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chats{
  // static Chats? _instance;
  final String? senderId;
  final String? receiverId;
  Chats({required this.senderId, required this.receiverId});
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}

class Messages{
  String timestamp;
  String message;
  bool seen = true;
  Messages({required this.timestamp, required this.message});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'timestamp': timestamp,
      'seen': seen
    };
  }
}