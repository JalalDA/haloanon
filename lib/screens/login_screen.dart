import 'package:duapuluhnolnol/components/custom_button.dart';
import 'package:duapuluhnolnol/components/custom_textfield.dart';
import 'package:duapuluhnolnol/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  final void Function()? ontap;
  const LoginScreen({super.key, required this.ontap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  //login method
  void login()async{
    //show loading
    showDialog(
      context: context, 
      builder: (context)=>const Center(
        child: CircularProgressIndicator(),
      ));

      //try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        //pop loading
        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading
        Navigator.pop(context);
        displayMessageError(e.code, context);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 25,
              ),
              //app name
              const Text(
                "Halo Anon",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              //textfield email
              CustomTextField(
                  hintText: "Email",
                  obsecureText: false,
                  controller: emailController),
              const SizedBox(
                height: 25,
              ),
              //textfield password
              CustomTextField(
                  hintText: "Password",
                  obsecureText: true,
                  controller: passwordController),
              const SizedBox(
                height: 14,
              ),
              //forgot password
              const Row(
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              //sign in button
              CustomButton(text: "Login", ontap: login),
              const SizedBox(
                height: 14,
              ),
              //register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: widget.ontap,
                    child: Text(
                      "   Register here",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
