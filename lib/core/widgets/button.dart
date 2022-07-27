import 'package:flutter/material.dart';
import '../util/style.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.lable, required this.onTap})
      : super(key: key);

  final String lable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 45,
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryClr,
        ),
        child: TextButton(
          onPressed: onTap,
          child: Text(
            lable,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
