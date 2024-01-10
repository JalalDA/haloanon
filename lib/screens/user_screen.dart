import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duapuluhnolnol/screens/chat_screen.dart';
import 'package:duapuluhnolnol/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //handle signout
    void signOut() {
      //instance initiate
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.signOut();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("User"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
          child: _buildUserList(context),
        ),
    );
  }

  // build a list of users except for the curent user
  Widget _buildUserList(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(), 
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text("Something wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading . . .");
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc, context)).toList(),
        );
      }
      );
  }

  //build single user list item
  Widget _buildUserListItem(DocumentSnapshot document, BuildContext context){
          //instance of auth
    final _auth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display user except current user
    if(_auth.currentUser!.email != data["email"]){
      return ListTile(
        title: Text(data["email"]),
        onTap: (){
          //pass the user id to chat page
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=> ChatScreen( 
              receivedUserEmail: data["email"],
              receivedUserId: data['uid'],
            )));
        },
      );
    }else{
      //return empty container
      return Container();
    }
  }
}
