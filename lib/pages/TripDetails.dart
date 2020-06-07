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
              Tags(
            key:_tagStateKey,
            textField: TagsTextField(
              textStyle: TextStyle(fontSize: _fontSize),
              constraintSuggestion: true, suggestions: [],
              onSubmitted: (String str) {
                // Add item to the data source.
                setState(() {
                  // required
                  _items.add(str);
                });
              },
            ),
            itemCount: _items.length, // required
            itemBuilder: (int index){
              final item = _items[index];

              return ItemTags(
                // Each ItemTags must contain a Key. Keys allow Flutter to
                // uniquely identify widgets.
                key: Key(index.toString()),
                index: index, // required
                title: item.title,
                active: item.active,
                customData: item.customData,
                textStyle: TextStyle( fontSize: _fontSize, ),
                combine: ItemTagsCombine.withTextBefore,
                image: ItemTagsImage(
                    image: AssetImage("img.jpg") // OR NetworkImage("https://...image.png")
                ), // OR null,
                icon: ItemTagsIcon(
                  icon: Icons.add,
                ), // OR null,
                removeButton: ItemTagsRemoveButton(
                  onRemoved: (){
                    // Remove the item from the data source.
                    setState(() {
                      // required
                      _items.removeAt(index);
                    });
                    //required
                    return true;
                  },
                ), // OR null,
                onPressed: (item) => print(item),
                onLongPressed: (item) => print(item),
              );

            },
          )
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
