import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  Function callback;
  var selectedNavigationIndex;

  BottomBar(this.callback, this.selectedNavigationIndex);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 100,
            padding: EdgeInsets.only(bottom: 25, left: 45, right: 45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 40,
                      offset: Offset(1, 3),
                      color: Colors.black,
                      spreadRadius: -40)
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90.0),
                  topRight: Radius.circular(90.0),
                  bottomLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(90.0),
                ),
                child: Container(
                    color: Colors.white,
                    child: DefaultTabController(
                        length: 4, // Added
                        initialIndex: 0, //Added
                        child: new TabBar(
                          tabs: [
                            _individualTab('assets/img/navigate.png'),
                            _individualTab('assets/img/earth.png'),
                            _individualTab('assets/img/list.png'),
                            Tab(icon: Image( ///Keep this as is
                                image: new AssetImage('assets/img/share.png'),
                                color: null,
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                            ))
                          ],
                          onTap: (int _selectedNavigationIndex) {
                            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
                            return setState(() {
                              this.widget.selectedNavigationIndex =
                                  this.widget.selectedNavigationIndex;
                              this.widget.callback(
                                  _selectedNavigationIndex); //Callback to Main
                            });
                          },
                          labelColor: Colors.green,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.all(0),
                          indicatorPadding: EdgeInsets.all(0),
                        )
                    )
                )
            )
        )
    );
  }

  Widget _individualTab(String imagePath) {
    return Container(
      height: 75 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Colors.grey.withOpacity(0.5), width: 2, style: BorderStyle.solid))),
      child: Tab(
        icon: Image(
          image: new AssetImage(imagePath),
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
