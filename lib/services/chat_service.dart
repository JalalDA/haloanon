import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duapuluhnolnol/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //SEND MESSAGE

  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String curentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message

    Message newMessage = Message(
        sendirId: currentUserId,
        senderEmail: curentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //construct chat room id from curent user id and receiver id

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add message to db
    await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //GET MESSAGE
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    //construct chat room di from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomid = ids.join("_");
    return _fireStore
        .collection("chat_rooms")
        .doc(chatRoomid)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
