import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/UnlockPremiumButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Premium extends StatefulWidget {
  Function callbackGoPremium;
  Premium(this.callbackGoPremium);

  @override
  State<Premium> createState() => PremiumState();
}

class PremiumState extends State<Premium> {

  bool openSubscriptionMenu = false;

  goPremiumButtonCallback(bool goPremiumButtonClicked){
    this.widget.callbackGoPremium(true);
  }

  @override
  initState() {
    super.initState();


  }

  updateState() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 60),
                              child: Align(
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  iconSize: 64,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 64.0,
                                    semanticLabel:
                                    'Text to announce in accessibility modes',
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Align(
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ]),
                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                              size: 64.0,
                              semanticLabel:
                              'Text to announce in accessibility modes',
                            ),
                            onPressed: () {
                              goPremiumButtonCallback(false);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset('assets/img/Owlking.png')),
                        ),
                      ]),
                      SizedBox(height: 10),

                      Text(
                          AppLocalizations.of(context)
                              .translate('premium')
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 33,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Text(
                          AppLocalizations.of(context)
                              .translate('membership')
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 33,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Text('4.99/ month',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text('49.99/ year',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),


                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 30),
                child:  Text(
                    AppLocalizations.of(context)
                        .translate('set_your_radius'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 30),
                child:    Text(
                    AppLocalizations.of(context)
                        .translate('get_800_points_per_month'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 30),
                child:    Text(
                    AppLocalizations.of(context)
                        .translate('access_quantum_power'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 30),
                child:    Text(
                    AppLocalizations.of(context)
                        .translate('labs_coming_soon'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 30),
                child:    Text(
                    AppLocalizations.of(context)
                        .translate('access_quantum_power'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 50),
              Align(
                  alignment: Alignment.center,
                  child: UnlockPremiumButton(this.goPremiumButtonCallback)
              ),
            ])
    );
  } //Funct

}
