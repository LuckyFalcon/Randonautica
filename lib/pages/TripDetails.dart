import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';



class TripDetails extends StatefulWidget {

  TripDetails(this.location, this.dateTime);
  String location;
  String dateTime;

  @override
  State<TripDetails> createState() => TripDetailsState();
}

class TripDetailsState extends State<TripDetails> {

  List _items;
  double _fontSize = 14;

  @override
  void initState() {
    super.initState();
    location = this.widget.location;
    dateTime = this.widget.dateTime;

  }
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
                stops: [0, 1],
                colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
        child: Center(
          child: Column(
            children: <Widget>[
              TopBar(),
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
              ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
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

            ],
          ),
        ),
      ),
    );
  }

}

final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// Allows you to get a list of all the ItemTags
_getAllItem(){
  List<Item> lst = _tagStateKey.currentState?.getAllItem;
  if(lst!=null)
    lst.where((a) => a.active==true).forEach( ( a) => print(a.title));
}
