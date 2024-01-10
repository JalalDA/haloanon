import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sendirId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.sendirId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp
  });

  //convert to map

  Map<String, dynamic> toMap(){
    return {
      "senderId" : sendirId,
      "senderEmail" : senderEmail,
      "receiverId" : receiverId,
      "message" : message,
      "timestamp" : timestamp,
    };
  }
}