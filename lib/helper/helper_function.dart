import 'package:flutter/material.dart';

//display message error to user
void displayMessageError(String message, BuildContext context){
  showDialog(
    context: context, 
    builder: (context)=>AlertDialog(
      title: Text(message),
    ));
}