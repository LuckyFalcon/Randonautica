import 'dart:async';
import 'dart:io';

import 'package:app/api/verifyIAP.dart';
import 'package:app/components/FadingCircleLoading.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/storage/userDatabase.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/currentUser.dart' as user;
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class Shop extends StatefulWidget {
//  Function callbackGoPremium;
//
//  Shop(this.callbackGoPremium);

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

  var AutoSizeTextGroupTop = AutoSizeGroup();
  var AutoSizeTextGroupItems = AutoSizeGroup();

  goPremiumButton(bool goPremiumButtonClicked) {
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
        //print('Acknowledged:' + productItem.originalJsonAndroid);
        //FlutterInappPurchase.instance.consumePurchaseAndroid(productItem.purchaseToken);
        //print('Acknowledged:' + productItem.originalJsonAndroid);
        print('Acknowledged:' + productItem.isAcknowledgedAndroid.toString());
        FlutterInappPurchase.instance.acknowledgePurchaseAndroid(
            productItem.purchaseToken,
            developerPayload: "");
        print('Acknowledged:' + productItem.isAcknowledgedAndroid.toString());
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
    return shoploaded ? Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: backgrounds.normal,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: SizeConfig.blockSizeVertical * 60,
            width: SizeConfig.blockSizeHorizontal * 80,
            child: Stack(
              children: <Widget>[
                Container(
                    height: SizeConfig.blockSizeVertical * 90,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            offset: Offset(0, 15),
                            color: Colors.black.withOpacity(.6),
                            spreadRadius: -9)
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 20),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 33.3,
                                  child: IconButton(
                                    iconSize: 64,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff5988E3),
                                      size: 64.0,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                IconButton(
                                  iconSize: 64,
                                  icon: ImageIcon(
                                      AssetImage('assets/img/Home.png'),
                                      size: 64.0,
                                      color: Color(0xff5988E3)),
                                  onPressed: () {},
                                ),
                              ]),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 15),
                              Container(
                                height: SizeConfig.blockSizeVertical * 10,
                                child:  Container(
                                    child: Image.asset(
                                        'assets/img/Owl_Token.png',
                                        color: Color(0xff5988E3),
                                        height: 128,
                                        width: 128))
                              ),
                              Container(
                                  height: SizeConfig.blockSizeVertical * 6,
                                  child: AutoSizeText(
                                      user.currentUser.points.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 64,
                                          color: Color(0xff37CDDC),
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                              _productListTokenAmount[1],
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Color(0xff37CDDC))),
                                          Image.asset(
                                              'assets/img/Owl_Token.png',
                                              color: Color(0xff37CDDC),
                                              height: 32,
                                              width: 32),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                              _productListTokenAmount[1],
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Color(0xff37CDDC))),
                                          Image.asset(
                                              'assets/img/Owl_Token.png',
                                              color: Color(0xff37CDDC),
                                              height: 32,
                                              width: 32),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                              _productListTokenAmount[1],
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Color(0xff37CDDC))),
                                          Image.asset(
                                              'assets/img/Owl_Token.png',
                                              color: Color(0xff37CDDC),
                                              height: 32,
                                              width: 32),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                              _productListTokenAmount[1],
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Color(0xff37CDDC))),
                                          Image.asset(
                                              'assets/img/Owl_Token.png',
                                              color: Color(0xff37CDDC),
                                              height: 32,
                                              width: 32),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        children: <Widget>[
                                          AutoSizeText(
                                              AppLocalizations.of(context)
                                                  .translate('extend_radius'),
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                fontSize: 23,
                                                color: Color(0xff37CDDC),
                                              )),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 30),
                                      child: Row(
                                        children: <Widget>[
                                          AutoSizeText(
                                              AppLocalizations.of(context)
                                                  .translate('extend_radius'),
                                              group: AutoSizeTextGroupItems,
                                              style: TextStyle(
                                                fontSize: 23,
                                                color: Color(0xff37CDDC),
                                              )),
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                            _items[sixtyOwlTokenIndex]
                                                .localizedPrice
                                                .toString(),
                                            group: AutoSizeTextGroupItems,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Color(0xff37CDDC))),
                                        IconButton(
                                          icon: ImageIcon(
                                              AssetImage(
                                                  'assets/img/double_arrow.png'),
                                              size: 40.0,
                                              color: Color(0xff37CDDC)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ) : FadingCircleLoading(
    color: Colors.white,
    size: 75.0,
    );
  } //Funct

}
