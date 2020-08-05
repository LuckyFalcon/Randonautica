import 'package:app/components/Introduction/EnterRandonauticaButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class VisitScreen extends StatefulWidget {
  @override
  State<VisitScreen> createState() => VisitScreenState();
}

class VisitScreenState extends State<VisitScreen> {

  @override
  initState() {
    super.initState();
  }

  updateState() {
    setState(() {});
  }

  welcomePremiumButtonCallback() {

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.yellow[200],
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: Center(
            child: Column(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 25),
                ImageIcon(
                  AssetImage('assets/img/Owlking.png'),
                  color: Colors.white,
                  size: 128.0,
                ),
                SizedBox(height: 10),
                Container(
                  width: SizeConfig.blockSizeHorizontal * (70),
                  child: Text(AppLocalizations.of(context).translate('write_the_story').toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                EnterRandonauticaButton()
              ])
            ]),
          )),
    );
  } //Function
}
