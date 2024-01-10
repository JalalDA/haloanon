import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duapuluhnolnol/components/custom_button.dart';
import 'package:duapuluhnolnol/components/custom_textfield.dart';
import 'package:duapuluhnolnol/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  final void Function()? ontap;
  const RegisterScreen({super.key, required this.ontap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  //list random username
  List<String> myList = [
    'Koala Lucu',
    'Singa Gabut',
    'Monster Imut',
    'Babi Jenaka',
    'Babi Lucu',
    "Musang Jinak",
    "Koala Kumal",
    "Singa Imut",
    "Hiu Lucu",
    "Marmut Galak",
    "Kucing Tua",
    "Kucing lucu"
  ]; 

  //objek random
  Random random = Random();

  String getRandomElement(List<String> list, Random random) {
    // Using nextInt to get a random index
    int randomIndex = random.nextInt(list.length);

    // Returning the random element from the list
    return list[randomIndex];
  }

  //register method
  void registerUser() async {
    //show loading
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    //make sure password match
    if (passwordController.text != confirmPasswordController.text) {
      //pop loading
      Navigator.pop(context);

      //show error message to user
      return displayMessageError(
          "Password and confirm password doesn't match", context);
    }

    //try creating user
    try {
      //creating user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      //create a user document an add to firestore
      createUserDocument(userCredential);

      //pop loading
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageError(e.code, context);
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    String randomUsername = getRandomElement(myList, Random());
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "usernamae": randomUsername
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(getRandomElement(myList, Random()));
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
              CustomTextField(
                  hintText: "Confirm Password",
                  obsecureText: true,
                  controller: confirmPasswordController),
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
              CustomButton(text: "Register", ontap: registerUser),
              const SizedBox(
                height: 14,
              ),
              //register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: widget.ontap,
                    child: const Text(
                      "   Login here",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
