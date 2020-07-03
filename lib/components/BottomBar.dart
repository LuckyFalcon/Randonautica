import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  Color selectedColor = Color(0xff6080E2);
  Color unselectedColor = Color(0xff37CCDC);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: SizeConfig.blockSizeHorizontal * 18,
            padding: EdgeInsets.only(bottom: 0, left: 45, right: 45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 35,
                      offset: Offset(1, 10),
                      color: Colors.black,
                      spreadRadius: -60)
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
                            (this.widget.selectedNavigationIndex == 0 ? _individualTab('assets/img/Pin_Point.svg', selectedColor) : _individualTab('assets/img/Pin_Point.svg', unselectedColor)),
                            (this.widget.selectedNavigationIndex == 1 ? _individualTab('assets/img/Globe.svg', selectedColor) : _individualTab('assets/img/Globe.svg', unselectedColor)),
                            (this.widget.selectedNavigationIndex == 2 ? _individualTab('assets/img/List.svg', selectedColor) : _individualTab('assets/img/List.svg', unselectedColor)),
                             Tab(icon: SvgPicture.asset(
                                'assets/img/Labs.svg',
                                height: 48,
                                width: 48,
                                color: (this.widget.selectedNavigationIndex == 3 ? selectedColor : unselectedColor),
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
                          labelColor: Colors.blue,
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

  Widget _individualTab(String imagePath, tabColor) {
    return Container(
      height: 75 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Colors.grey.withOpacity(0.5), width: 2, style: BorderStyle.solid))),
      child: Tab(
        icon: SvgPicture.asset(
            imagePath,
            height: 48,
            width: 48,
            color: tabColor,
      )
      ),
    );
  }
}
