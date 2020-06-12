import 'package:app/pages/NewsItemDetails.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageURL;

  const NewsItem({Key key, this.firstName, this.lastName, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: 350,
          child: Row(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 50,
                child: IconButton(
                    icon: new Image.asset('assets/img/inboxicon.png'),
                    iconSize: 80,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewsItemDetails('now', 'ámsterdam')),
                      );
                    }),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Sender name',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'A svt, or in a pod',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              'Sender name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
//Container(
//        height: 100,
//        width: 350,
//        child: Column(
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                IconButton(
//                    icon: new Image.asset('assets/img/inboxicon.png'),
//                    iconSize: 80,
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) =>
//                                NewsItemDetails('now', 'ámsterdam')),
//                      );
//                    }),
//                Text(
//                  'Day 1',
//                  style: TextStyle(
//                    color: Colors.white,
//                  ),
//                ),
//                IconButton(
//                  onPressed: () {},
//                  icon: Icon(Icons.more_vert),
//                ),
//              ],
//            ),
//          ],
//        ),
//      );

//    Container(
//        child:
//
//
//
//        Column(
//      children: <Widget>[
//        Row(
//            children: [
//          Container(
//            child: Align(
//              child: IconButton(
//                  icon: new Image.asset('assets/img/inboxicon.png'),
//                  iconSize: 80,
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              NewsItemDetails('now', 'ámsterdam')),
//                    );
//                  }),
//            ),
//          ),
//          Align(
//            alignment: Alignment.topLeft,
//
//            child: Text(
//              "ex 4:22PM",
//              overflow: TextOverflow.ellipsis,
//              style:
//                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//            ),
//          ),
//        ])
//      ],
//    ));
  }
}
