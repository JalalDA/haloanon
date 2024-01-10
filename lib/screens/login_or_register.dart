import 'package:duapuluhnolnol/screens/login_screen.dart';
import 'package:duapuluhnolnol/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially, show login page
  bool showLoginPage = true;

  void toggleLoginPages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(ontap: toggleLoginPages,);
    }else{
      return RegisterScreen(ontap: toggleLoginPages,);
    }
  }
}