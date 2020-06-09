import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/storage/createDatabases.dart';
import 'package:app/pages/start/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();

    ///TODO await Create Databases & check whether it already exists
    createDatabases();

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
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
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