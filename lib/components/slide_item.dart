import 'package:app/models/slide.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: 220,
            child: new Column(
              children: <Widget>[
                Text(
                  returnSlide(index, context).descriptionone,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14),
                )
              ],
            )),
        SizedBox(
          height: 5,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: 250,
            child: new Column(
              children: <Widget>[
                Text(
                  slideList[index].descriptiontwo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ],
            )),
        SizedBox(
          height: 5,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: 200,
            child: new Column(
              children: <Widget>[
                Text(
                  slideList[index].descriptionthree,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ],
            )),
      ],
    );
  }
}
