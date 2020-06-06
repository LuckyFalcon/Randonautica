import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 24 : 16,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.lightBlueAccent : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}