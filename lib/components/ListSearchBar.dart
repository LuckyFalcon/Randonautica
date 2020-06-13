import 'dart:math';

import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/models/Post.dart';
import 'package:app/utils/size_config.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TopBar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchBarController createState() => _SearchBarController();
}

class _SearchBarController extends State<SearchPage> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts
          .add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: <Widget>[
            TopBar(),
            Expanded(
              child:
              Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context); //Go back to previous navigation item
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 40.0,
                      ),
                  ),
                ),
                  SearchBar<Post>(
                    searchBarPadding: EdgeInsets.only(left: 75, right: 50),
                    headerPadding: EdgeInsets.symmetric(horizontal: 10),
                    listPadding: EdgeInsets.symmetric(horizontal: 10),
                    onSearch: _getALlPosts,
                    searchBarStyle: SearchBarStyle(
                        padding: EdgeInsets.only(left: 15),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        backgroundColor: Color(0xff7FB1FE)),
                    searchBarController: _searchBarController,
                    placeHolder:
                    Container(
                        padding: const EdgeInsets.only(left: 50),
                        width: SizeConfig.blockSizeHorizontal * 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                AppLocalizations.of(context)
                                    .translate('try_searching'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_1'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_2'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_3'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_4'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_5'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('search_list_item_6'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],

                        )),
                    icon: Icon(
                      Icons.search,
                      color: Color(0xff5E80E1),
                      size: 20.0,
                    ),
                    hintText: "SEARCH",
                      hintStyle: TextStyle(color: Color(0xff5E80E1)),
                    emptyWidget: Text("empty"),
                    indexedScaledTileBuilder: (int index) =>
                        ScaledTile.count(1, index.isEven ? 2 : 1),
                    onCancelled: () {
                      print("Cancelled triggered");
                    },
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    onItemFound: (Post post, int index) {
                      return Container(
                        color: Colors.lightBlue,
                        child: ListTile(
                          title: Text(post.title),
                          isThreeLine: true,
                          subtitle: Text(post.body),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Detail()));
                          },
                        ),
                      );
                    },
                  ),

                ],
              )


            ),
          ],
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
