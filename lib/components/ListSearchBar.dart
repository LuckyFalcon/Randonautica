import 'dart:math';

import 'package:app/models/Post.dart';
import 'package:app/pages/TripDetails.dart';
import 'package:app/pages/UnloggedTripDetails.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class ListSearchBar extends StatelessWidget {
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
    return SafeArea(
      child: SearchBar<Post>(
        searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        headerPadding: EdgeInsets.symmetric(horizontal: 10),
        listPadding: EdgeInsets.symmetric(horizontal: 10),
        onSearch: _getALlPosts,
        searchBarController: _searchBarController,
        cancellationWidget: Text("Cancel"),
        hintText: "SEARCH",
        indexedScaledTileBuilder: (int index) =>
            ScaledTile.count(1, index.isEven ? 2 : 1),
        onCancelled: () {
          print("Cancelled triggered");
        },
        searchBarStyle: SearchBarStyle(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(90),
        ),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TripDetails('123', 'amstel')));
              },
            ),
          );
        },
      ),
    );
  }
}
