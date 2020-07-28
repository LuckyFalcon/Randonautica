import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class NewsItemDetails extends StatelessWidget {
  NewsItemDetails(this.location, this.dateTime);

  String location;
  String dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [0, 100],
                colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    location + ' ' + dateTime,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
              Image(image: AssetImage('assets/img/add_media.png')),
              Container(
                  height: 60,
                  padding: EdgeInsets.only(bottom: 25, left: 50, right: 45),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7BBFFE),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              border: InputBorder.none,
                              labelText: AppLocalizations.of(context)
                                  .translate('give_trip_a_name'),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))))),
              Container(
                  height: 150,
                  padding: EdgeInsets.only(bottom: 10, left: 45, right: 45),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7BBFFE),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 10, left: 25, right: 45),
                              border: InputBorder.none,
                              labelText: AppLocalizations.of(context)
                                  .translate('tell_your_story'),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))))),
            ],
          ),
        ),
      ),
    );
  }
}