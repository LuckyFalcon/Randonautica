import 'file:///E:/Randonautica/randonautica/lib/components/News/NewsItem.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  State<News> createState() => NewsState();
}

class NewsState extends State<News> {



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
  void initState() {
    super.initState();

  }

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
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
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
                            ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: 2,
                                    indent: 20,
                                    endIndent: 20,
                                  );
                                },
                                physics: ScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return new NewsItem(
                                    firstName: userdetails[index]['first_name'],
                                    lastName: userdetails[index]['last_name'],
                                    imageURL: userdetails[index]['image_url'],
                                  );
                                })
                          ],
                        )))
              ],
            ),
          )),
    );
  } //Functions


  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Rate",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[


                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Rate Product",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
