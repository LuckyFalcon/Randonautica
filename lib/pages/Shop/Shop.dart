import 'dart:async';
import 'dart:io';

import 'package:app/api/verifyIAP.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/UnlockPremiumButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadingCircleLoading.dart';
import 'package:app/helpers/storage/userDatabase.dart';
import 'package:app/utils/currentUser.dart' as currentUser;
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

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
  var hundredFiftyOwlTokenIndex;
  var fivehundredOwlTokenIndex;
  var fifteenhundredOwlTokenIndex;
  var extendradiusIndex;
  var skipwaterpointsIndex;

  final List<String> _productListTokenAmount = ['60', '150', '500', '1500'];

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

  goPremiumButtonCallback(bool goPremiumButtonClicked) {
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
    super.dispose();
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

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      print('purchase-updated' + productItem.purchaseStateAndroid.toString());
      if (Platform.isAndroid) {
        await verifyIAPConsumableGoogle(productItem)
            .catchError((onError) => {print(onError)});
      }
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
    // purchase(sixtyOwlTokenIndex);

    setState(() {
      shoploaded = true;
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var i = 0; i < items.length; i++) {
      if (items[i].productId == "20_owl_tokens") {
        twentyOwlTokenIndex = i;
      }
      if (items[i].productId == "60_owl_tokens") {
        sixtyOwlTokenIndex = i;
      }
      if (items[i].productId == "150_owl_tokens") {
        hundredFiftyOwlTokenIndex = i;
      }
      if (items[i].productId == "500_owl_tokens") {
        fivehundredOwlTokenIndex = i;
      }
      if (items[i].productId == "1500_owl_tokens") {
        fifteenhundredOwlTokenIndex = i;
      }
      if (items[i].productId == "extend_radius") {
        extendradiusIndex = i;
      }
      if (items[i].productId == "skip_water_points") {
        skipwaterpointsIndex = i;
      }
      print(items[i].productId);
    }
    enableWaterPointsPurchase();
    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    print('test' + items.toString());
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
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      if (item.productId == "get_more_points") {}
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
    setState(() {});
  }

  enableWaterPointsPurchase() async {
    await enableIsIapSkipWaterPoints();
    globals.currentUser = await RetrieveUser();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (shoploaded
        ? premiumShop
            ? Container(
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
                                padding:
                                    const EdgeInsets.only(top: 15, left: 60),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 15),
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
                                    child:
                                        Image.asset('assets/img/Owlking.png')),
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
                      child: Text(
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
                      child: Text(
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
                      child: Text(
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
                      child: Text(
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
                      child: Text(
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
                        child:
                            UnlockPremiumButton(this.goPremiumButtonCallback)),
                  ]))
            : Center(
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
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              iconSize: 64,
                              icon: ImageIcon(AssetImage('assets/img/Shop.png'),
                                  size: 64.0, color: Colors.white),
                              onPressed: () {
//                openAlertBox(context);
                                //     goToShop(true);
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
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 64.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        onPressed: () {
                          this.widget.callbackGoPremium(false);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55, bottom: 15),
                      child: Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/img/Owl_Token.png')),
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
                      Text(currentUser.currentUser.points.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(_productListTokenAmount[0],
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Image.asset(
                                'assets/img/Owl_Token.png',
                                width: 40,
                              ),
                              IconButton(
                                icon: ImageIcon(
                                    AssetImage('assets/img/double_arrow.png'),
                                    size: 64.0,
                                    color: Colors.white),
                                onPressed: () {
                                  purchase(sixtyOwlTokenIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              _items[sixtyOwlTokenIndex]
                                      .localizedPrice
                                      .toString() +
                                  '(' +
                                  ((double.parse(_items[sixtyOwlTokenIndex]
                                                  .price) /
                                              double.parse(
                                                  _productListTokenAmount[0]))
                                          .toString())
                                      .toString() +
                                  ' per' +
                                  ')',
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
                          padding: const EdgeInsets.only(top: 0.0, left: 30),
                          child: Row(
                            children: <Widget>[
                              Text(_productListTokenAmount[1],
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Image.asset(
                                'assets/img/Owl_Token.png',
                                width: 40,
                              ),
                              IconButton(
                                icon: ImageIcon(
                                    AssetImage('assets/img/double_arrow.png'),
                                    size: 64.0,
                                    color: Colors.white),
                                onPressed: () {
                                  purchase(sixtyOwlTokenIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              _items[sixtyOwlTokenIndex]
                                      .localizedPrice
                                      .toString() +
                                  '(' +
                                  ((double.parse(_items[sixtyOwlTokenIndex]
                                                  .price) /
                                              double.parse(
                                                  _productListTokenAmount[0]))
                                          .toString())
                                      .toString() +
                                  ' per' +
                                  ')',
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
                          padding: const EdgeInsets.only(top: 0.0, left: 30),
                          child: Row(
                            children: <Widget>[
                              Text(_productListTokenAmount[2],
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Image.asset(
                                'assets/img/Owl_Token.png',
                                width: 40,
                              ),
                              IconButton(
                                icon: ImageIcon(
                                    AssetImage('assets/img/double_arrow.png'),
                                    size: 64.0,
                                    color: Colors.white),
                                onPressed: () {
                                  purchase(fivehundredOwlTokenIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              _items[fivehundredOwlTokenIndex]
                                      .localizedPrice
                                      .toString() +
                                  '(' +
                                  ((double.parse(_items[
                                                      fivehundredOwlTokenIndex]
                                                  .price) /
                                              double.parse(
                                                  _productListTokenAmount[2]))
                                          .toStringAsFixed(3))
                                      .toString() +
                                  ' per' +
                                  ')',
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
                          padding: const EdgeInsets.only(top: 0.0, left: 30),
                          child: Row(
                            children: <Widget>[
                              Text(_productListTokenAmount[3],
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Image.asset(
                                'assets/img/Owl_Token.png',
                                width: 40,
                              ),
                              IconButton(
                                icon: ImageIcon(
                                    AssetImage('assets/img/double_arrow.png'),
                                    size: 64.0,
                                    color: Colors.white),
                                onPressed: () {
                                  purchase(fifteenhundredOwlTokenIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              _items[fifteenhundredOwlTokenIndex]
                                      .localizedPrice
                                      .toString() +
                                  '(' +
                                  ((double.parse(_items[
                                                      fifteenhundredOwlTokenIndex]
                                                  .price) /
                                              double.parse(
                                                  _productListTokenAmount[3]))
                                          .toStringAsFixed(3))
                                      .toString() +
                                  ' per' +
                                  ')',
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('share_with_friends'),
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: ImageIcon(
                                    AssetImage('assets/img/double_arrow.png'),
                                    size: 64.0,
                                    color: Colors.white),
                                onPressed: () {
                                  purchase(extendradiusIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(_items[extendradiusIndex].localizedPrice,
                              style: TextStyle(
                                  fontSize: 18,
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
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('skip_water_points'),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.pink,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                onPressed: () {
                                  purchase(skipwaterpointsIndex);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, right: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("464,000(0.0000 per)",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  GoPremiumButton(this.goPremiumButtonCallback)
                ],
              ))
        : FadingCircleLoading(
            color: Colors.white,
            size: 75.0,
          ));
  } //Funct

}
