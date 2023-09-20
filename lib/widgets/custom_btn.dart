import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String myTitle;
  final Function myFuntion;
  const CustomBtn({
    required this.myTitle,
    required this.myFuntion,
    super.key,
  });

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xfff31e79),
          Color(0xffFF7678),
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.myFuntion();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        child: Text(
          widget.myTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
