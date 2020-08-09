import 'package:app/components/Lab/LabEntry.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Lab extends StatefulWidget {
  @override
  State<Lab> createState() => LabState();
}

class LabState extends State<Lab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LabEntry();
  } //Functions
}
