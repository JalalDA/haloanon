

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {

  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  //post collection
  final CollectionReference posts = FirebaseFirestore.instance.collection("posts");

  //post a message
  Future<void> addPost(String message){
    return posts.add(
      {
        "email" : user!.email,
        "message" : message,
        "created_at" : Timestamp.now()
      }
    );
  }

  //read stream from database

  Stream<QuerySnapshot> getPostStream (){
    final postStream = FirebaseFirestore.instance.collection("posts").orderBy("created_at", descending:  true).snapshots();
    return postStream;
  }

}