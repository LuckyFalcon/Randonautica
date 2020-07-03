import 'dart:async';
import 'dart:io';

import 'package:app/api/verifyIAP.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadingCircleLoading.dart';
import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/utils/currentUser.dart' as user;

class Shop extends StatefulWidget {
  Function callbackGoPremium;
  Shop(this.callbackGoPremium);

  @override
  State<Shop> createState() => ShopState();
}

class ShopState extends State<Shop> {
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;

  bool shoploaded = false;
  bool premiumShop = false;

  var twentyOwlTokenIndex;
  var sixtyOwlTokenIndex;
  var fivehundredOwlTokenIndex;
  var fifteenhundredOwlTokenIndex;
  var extendradiusIndex;
  var skipwaterpointsIndex;

  final List<String> _productLists = Platform.isAndroid
      ? [
    '20_owl_tokens',
    '60_owl_tokens',
    '500_owl_tokens',
    '1500_owl_tokens',
    'extend_radius',
    'skip_water_points'
  ]
      : ['get_points', 'com.cooni.point5000'];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  bool openSubscriptionMenu = false;

  goPremiumButtonCallback(bool goPremiumButtonClicked){
    setState(() {
      premiumShop = goPremiumButtonClicked;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    await _getPurchaseHistory();
    await _getPurchases();
    await _getProduct();

    _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      print('purchase-updated: $productItem');
      if(Platform.isAndroid){
        await verifyIAPConsumableGoogle(productItem).catchError((onError) => {
          print(onError)

        });
      } else {

      }

    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
    purchase(sixtyOwlTokenIndex);

    setState(() {
      shoploaded = true;

    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var i = 0; i < items.length; i++) {
      if(items[i].productId == "20_owl_tokens"){
      twentyOwlTokenIndex = i;
      }
      if(items[i].productId == "60_owl_tokens"){
        sixtyOwlTokenIndex = i;
      }
      if(items[i].productId == "500_owl_tokens"){
        fivehundredOwlTokenIndex = i;
      }
      if(items[i].productId == "1500_owl_tokens"){
        fifteenhundredOwlTokenIndex = i;
      }
      if(items[i].productId == "extend_radius"){
        extendradiusIndex = i;
      }
      if(items[i].productId == "skip_water_points"){
        skipwaterpointsIndex = i;
      }
      print(items[i].productId);

    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
    await FlutterInappPurchase.instance.getAvailablePurchases();
    print('test'+items.toString());
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem> items = await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      if(item.productId == "get_more_points"){


      }
      print('history ${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  void purchase(index) {
    FlutterInappPurchase.instance.requestPurchase(_items[index].productId);
  }



  updateState() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (shoploaded ?

    premiumShop ? Center(
      child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 80),
                        child: Align(
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 44.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 15),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            iconSize: 32,
                            icon: ImageIcon(AssetImage('assets/img/Shop.png'),
                                size: 64.0, color: Colors.white),
                            onPressed: () {
//                openAlertBox(context);

                            },
                          ),
                        ),
                      ),
                    ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: IconButton(
                      iconSize: 64,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 44.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 60),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/img/Owl_Token.png')
                    ),
                  ),
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        AppLocalizations.of(context)
                            .translate('owl_tokens')
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: 10),
                    Text(
                        user.currentUser.points.toString(),
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        AppLocalizations.of(context)
                            .translate('daily_allowence')
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('20',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 30),
                Text(AppLocalizations.of(context).translate('store'),
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('60',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        Image.asset('assets/img/Owl_Token.png', width: 40,)
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(_items[sixtyOwlTokenIndex].localizedPrice.toString(),
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('150',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset('assets/img/Owl_Token.png', width: 40,)
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(_items[sixtyOwlTokenIndex].localizedPrice.toString(),
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('500',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset('assets/img/Owl_Token.png', width: 40,)
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("1.99 (.03 per)",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('1500',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset('assets/img/Owl_Token.png', width: 40,)
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("1.99 (.03 per)",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('Extend Radius',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("1.99 (.03 per)",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('Extend Radius',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("1.99 (.03 per)",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),

                  ],
                ),
                GoPremiumButton(this.goPremiumButtonCallback)
              ],
            )
    ) : Center(
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 80),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 64,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 44.0,
                          semanticLabel:
                          'Text to announce in accessibility modes',
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 32,
                        icon: ImageIcon(AssetImage('assets/img/Shop.png'),
                            size: 64.0, color: Colors.white),
                        onPressed: () {
//                openAlertBox(context);

                        },
                      ),
                    ),
                  ),
                ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: IconButton(
                  iconSize: 64,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 44.0,
                    semanticLabel:
                    'Text to announce in accessibility modes',
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 60),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/img/Owl_Token.png')
                ),
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    AppLocalizations.of(context)
                        .translate('owl_tokens')
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: 10),
                Text(
                    user.currentUser.points.toString(),
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    AppLocalizations.of(context)
                        .translate('daily_allowence')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('20',
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 30),
            Text(AppLocalizations.of(context).translate('store'),
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('60',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Image.asset('assets/img/Owl_Token.png', width: 40,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(_items[sixtyOwlTokenIndex].localizedPrice.toString(),
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('150',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Image.asset('assets/img/Owl_Token.png', width: 40,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(_items[sixtyOwlTokenIndex].localizedPrice.toString(),
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('500',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Image.asset('assets/img/Owl_Token.png', width: 40,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("1.99 (.03 per)",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('1500',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Image.asset('assets/img/Owl_Token.png', width: 40,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("1.99 (.03 per)",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('Extend Radius',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("1.99 (.03 per)",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text('Extend Radius',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("1.99 (.03 per)",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),

              ],
            ),
            GoPremiumButton(this.goPremiumButtonCallback)
          ],
        )
    )

        : FadingCircleLoading(
      color: Colors.white,
      size: 75.0,
    ));
  } //Funct

}
