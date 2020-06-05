import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageURL;

  const NewsItem({Key key, this.firstName, this.lastName, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Divider(
        color: Colors.white,
        height: 20,
        thickness: 4,
        indent: 20,
        endIndent: 20,
      ),
      Container(
        child: new ListTile(
          leading: new FadeInImage(
            placeholder: new AssetImage('assets/me.jpg'),
            image: new NetworkImage(imageURL),
          ),
          title: new Text("First Name : " + firstName),
          subtitle: new Text("Last Name : " + lastName),
        ),
      ),
    ]);
  }
}
