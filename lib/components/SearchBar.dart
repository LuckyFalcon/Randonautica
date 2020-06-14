import 'package:app/helpers/FadeRoute.dart';

import 'ListSearchBar.dart';
import 'package:app/pages/News.dart';
import 'package:app/pages/Profile.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/AppLocalizations.dart';

class SearchBar extends StatelessWidget {
  var _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        height: SizeConfig.blockSizeVertical * 6,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Container(
          padding: EdgeInsets.only(left: 50, right: 45),
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff7FB1FE),
                borderRadius: BorderRadius.circular(90),
              ),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, FadeRoute(page: SearchPage()));
                  },
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Color(0xff5E80E1),
                        size: 20.0,
                      ),
                      SizedBox(width: SizeConfig.blockSizeVertical * 1),
                      Text(
                        'SEARCH',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xff5E80E1), fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xff5E80E1),
                          size: 20.0,
                        ),
                      ),

                    ],
                  )


              )),
        ));
  }
}