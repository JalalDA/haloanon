

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duapuluhnolnol/components/chat_buble.dart';
import 'package:duapuluhnolnol/components/cs_text_field.dart';
import 'package:duapuluhnolnol/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String receivedUserId;
  final String receivedUserEmail;

  const ChatScreen(
      {super.key,
      required this.receivedUserEmail,
      required this.receivedUserId});
  @override
  Widget build(BuildContext context) {
  final ChatService _chatService = ChatService();
      final TextEditingController _messageController = TextEditingController();
    //text input chat
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    void sendMessage() async {
      if (_messageController.text.isNotEmpty) {
        await _chatService.sendMessage(receivedUserId, _messageController.text);
        //clear text controller after sending message
        _messageController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(receivedUserEmail),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessage(receivedUserId, _firebaseAuth.currentUser!.uid),
              builder:(context, snapshot){
                if(snapshot.hasError){
                  return const Text("error");
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Text("loading . . .");
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc, _firebaseAuth) ).toList(),
                );
              },
              )
          ),
          //user input
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                //textfield
                Expanded(
                child: CsTextField(
                  controller: _messageController,
                  hintText: "Input Message",
                  obsecureText: false,
            ),
                  ),
                  IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_circle_right_sharp))
                ],
              ),
          ),
        ],
      ),
    );
  }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot document, FirebaseAuth _firebaseAuth){
        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the message left or right
    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["senderEmail"]),
            const SizedBox(height: 8),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );


  }
}
