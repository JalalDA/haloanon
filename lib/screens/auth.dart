import 'package:duapuluhnolnol/screens/login_or_register.dart';
import 'package:duapuluhnolnol/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return MainScreen();
          }else{
            return const LoginOrRegister();
          }
        },
        ),
    );
  }
}