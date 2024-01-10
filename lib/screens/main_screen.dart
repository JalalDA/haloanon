import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duapuluhnolnol/components/button_post.dart';
import 'package:duapuluhnolnol/components/custom_textfield.dart';
import 'package:duapuluhnolnol/database/firestore.dart';
import 'package:duapuluhnolnol/screens/drawer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();
  //post text controlller
  final TextEditingController newPostController = TextEditingController();

  //post message method
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  //logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
                onTap: logout,
                child: const Icon(
                  Icons.logout,
                  size: 30,
                )),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: Column(children: [
        //Textfield for user to type,
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                    hintText: "Say something . . .",
                    obsecureText: false,
                    controller: newPostController),
              ),
              ButtonPost(ontap: postMessage)
            ],
          ),
        ),

        StreamBuilder(
          stream: database.getPostStream(),
          builder: (context, snapshot) {
            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //get all post
            final posts = snapshot.data!.docs;

            //no data?
            if (snapshot.data == null || posts.isEmpty) {
              return const Text("No post found");
            }
            //return a list
            return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    //get each single post
                    final post = posts[index];

                    //get data from each post 

                    String message = post["message"];
                    String email = post["email"];
                    Timestamp createdAt = post["created_at"];

                    //return as a list tile
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right:  16, bottom: 0, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: ListTile(
                          title: Text(message),
                          subtitle: Text(email),
                        ),
                      ),
                    );
                  }
                ));
          },
        )
      ]),
    );
  }
}
