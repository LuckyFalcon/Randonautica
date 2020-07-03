import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class AnomalyButton extends StatefulWidget {
  Function callback;

  AnomalyButton(this.callback);

  State<StatefulWidget> createState() => new _AnomalyButton();
}

class _AnomalyButton extends State<AnomalyButton> {
  bool pressAttention1 = false;

  @override
  void initState() {
    super.initState();
  }

  void setButtonClicked() {
    this.widget.callback(true);

    setState(() => pressAttention1 = !pressAttention1);

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      width: 120.0,
      child: new ButtonTheme(
        minWidth: 120.0,
        height: 10.0,
        child: RaisedButton(
          elevation: pressAttention1 ? 15 : 0,
          color: pressAttention1 ? Colors.white : Color(0xff6BE5FE),
          onPressed: () => setButtonClicked(),
          textColor: pressAttention1 ? Colors.lightBlueAccent : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                  color:
                  pressAttention1 ? Colors.white : Colors.lightBlueAccent)),
          child: Text(
              AppLocalizations.of(context)
                  .translate('anomaly')
                  .toUpperCase(),
              style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
