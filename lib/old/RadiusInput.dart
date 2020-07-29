import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../helpers/AppLocalizations.dart';

class RadiusInput extends StatefulWidget {
  Function callback;
  @override
  RadiusInputState createState() => RadiusInputState();
}

class RadiusInputState extends State<RadiusInput> {
  var _radiusInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(placeholder: AppLocalizations.of(context).translate('radius_initial_text'),controller: _radiusInputController);
  }
}
