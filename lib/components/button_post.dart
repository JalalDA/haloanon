import 'package:flutter/material.dart';

class ButtonPost extends StatelessWidget {
  final void Function()? ontap;
  const ButtonPost({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        child: Center(
          child: Icon(Icons.done, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}