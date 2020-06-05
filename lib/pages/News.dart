import 'package:app/components/NewsItem.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  List userdetails = [
    {
      "first_name": "FLUTTER",
      "last_name": "AWESOME",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "FLUTTER",
      "last_name": "AWESOME",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          iconSize: 32,
                          icon: Icon(
                            Icons.arrow_back_ios,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 15),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).translate('news'),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.inbox,
                                color: Colors.white,
                                size: 48.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return new NewsItem(
                                    firstName: userdetails[index]['first_name'],
                                    lastName: userdetails[index]['last_name'],
                                    imageURL: userdetails[index]['image_url'],
                                  );
                                }),
                            Divider(
                              color: Colors.white,
                              height: 20,
                              thickness: 4,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ],
                        )))
              ],
            ),
          )),
    );
  } //Functions
}
