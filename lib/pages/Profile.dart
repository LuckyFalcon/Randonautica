import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 32,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 44.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  Image(
                    image: AssetImage('assets/img/Andronaut.png'),
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "Kerry",
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Edit Profile",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
              ],
            ),
          )),
    );
  }

//Functions

}
