import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'AppLocalizations.dart';

class RadiusInput extends StatefulWidget {

  @override
  RadiusInputState createState() => RadiusInputState();
}

class RadiusInputState extends State<RadiusInput> {
  TextEditingController _radiusInputController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(placeholder: AppLocalizations.of(context).translate('radius_initial_text'),controller: _radiusInputController);
  }
}
