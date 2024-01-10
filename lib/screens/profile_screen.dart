// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  //current loged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error
          else if (snapshot.hasError) {
            return Text("Error : ${snapshot.error}");
          } 
          if(snapshot.hasData){
            Map<String, dynamic>? user = snapshot.data!.data();
            print(user!["email"]);
            print(user);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //profile pic
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Icon(Icons.person, size:  64,),
                  ),
                  const SizedBox(height: 20,),
                  Text(user["usernamae"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  Text(user["email"])
                ],
              ),
            );
          }
          //data received
          // else if (snapshot.hasData) {
          //   String email = user != null ? user!['email'] : "Not found email";
          //   String username = user != null ? user!['username'] : "Not found username";
          //   print(user);
          //   return Column(
          //     children: [
          //       Text('$email'),
          //       Text('$username'),
          //     ],
          //   );
          // } 
          else {
            return const Text("No Data");
          }
        },
      ),
    );
  }
}
