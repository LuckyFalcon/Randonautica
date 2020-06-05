import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/pages/start/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => LoadingState();
}

class LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      ///Loading here or copy this to main.dart and do loading there
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody:true,
      backgroundColor: Colors.yellow[200],
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
          child: Center(
            child: Column(
                children: <Widget> [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 150),
                        ImageIcon(
                          AssetImage('assets/img/Owlking.png'),
                          color: Colors.white,
                          size: 128.0,
                        ),
                        SizedBox(height: 10),
                        Text(
                            AppLocalizations.of(context)
                                .translate('title'),
                            style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        SizedBox(height: 20),
                        CircularProgressIndicator()
                      ])
                ]
            ),
          )),
    );
  } //Functions
}