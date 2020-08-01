import 'dart:async';
import 'dart:io';

import 'package:app/api/verifyIAP.dart';
import 'package:app/components/Shop/GoPremiumButton.dart';
import 'package:app/components/Shop/UnlockPremiumButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import '../../components/FadingCircleLoading.dart';
import 'package:app/storage/userDatabase.dart';
import 'package:app/utils/currentUser.dart' as currentUser;
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
        FlutterInappPurchase.instance.acknowledgePurchaseAndroid(productItem.purchaseToken, developerPayload: "");
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
                                    goPremiumButton(false);
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
                            UnlockPremiumButton(this.goPremiumButton)),
                  ]))
            : Center(
                child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 10,
                    child: Row(children: [
                      Container(width: SizeConfig.blockSizeHorizontal * 33.3),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 33.3,
                        child: IconButton(
                          iconSize: 64,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(width: SizeConfig.blockSizeHorizontal * 10.3),
                      IconButton(
                        iconSize: 64,
                        icon: ImageIcon(AssetImage('assets/img/Shop.png'),
                            size: 64.0, color: Colors.white),
                        onPressed: () {
                          //                openAlertBox(context);
                          //   goToShop(true);
                        },
                      ),
                    ]),
                  ), ///Arrow & Shop icon
                  Container(
                    height: SizeConfig.blockSizeVertical * 10,
                    child: Row(children: [
                      Container(width: SizeConfig.blockSizeHorizontal * 33.3),
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 33.3,
                          child: Image.asset('assets/img/Owl_Token.png')),
                    ]),
                  ), ///OWL Token Icon
                  Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('owl_tokens')
                                .toUpperCase(),
                            group: AutoSizeTextGroupTop,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        SizedBox(width: 10),
                        AutoSizeText(currentUser.currentUser.points.toString(),
                            group: AutoSizeTextGroupTop,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ), ///Amount of Owl Tokens
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                              AppLocalizations.of(context)
                                  .translate('daily_allowence')
                                  .toUpperCase(),
                              group: AutoSizeTextGroupTop,
                              maxLines: 1,
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white)),
                          SizedBox(width: 10),
                          AutoSizeText('20',
                              group: AutoSizeTextGroupTop,
                              maxLines: 1,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      )), ///Daily Allowence
                  SizedBox(height: 15),
                  Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    child: AutoSizeText(
                        AppLocalizations.of(context).translate('store'),
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ), ///Store text
                  SizedBox(height: 15),
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(_productListTokenAmount[0],
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.green)),
                                  Image.asset(
                                    'assets/img/Owl_Token.png',
                                    width: 40,
                                  ),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(sixtyOwlTokenIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                  _items[sixtyOwlTokenIndex]
                                          .localizedPrice
                                          .toString() +
                                      '(' +
                                      ((double.parse(_items[sixtyOwlTokenIndex]
                                                      .price) /
                                                  double.parse(
                                                      _productListTokenAmount[
                                                          0]))
                                              .toString())
                                          .toString() +
                                      ' per' +
                                      ')',
                                  group: AutoSizeTextGroupItems,
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      )), ///60_owl_tokens
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(_productListTokenAmount[1],
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.green)),
                                  Image.asset(
                                    'assets/img/Owl_Token.png',
                                    width: 40,
                                  ),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(sixtyOwlTokenIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                  _items[sixtyOwlTokenIndex]
                                          .localizedPrice
                                          .toString() +
                                      '(' +
                                      ((double.parse(_items[sixtyOwlTokenIndex]
                                                      .price) /
                                                  double.parse(
                                                      _productListTokenAmount[
                                                          0]))
                                              .toString())
                                          .toString() +
                                      ' per' +
                                      ')',
                                  group: AutoSizeTextGroupItems,
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      )), ///150_owl_tokens
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(_productListTokenAmount[1],
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.green)),
                                  Image.asset(
                                    'assets/img/Owl_Token.png',
                                    width: 40,
                                  ),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(sixtyOwlTokenIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                  _items[sixtyOwlTokenIndex]
                                          .localizedPrice
                                          .toString() +
                                      '(' +
                                      ((double.parse(_items[sixtyOwlTokenIndex]
                                                      .price) /
                                                  double.parse(
                                                      _productListTokenAmount[
                                                          0]))
                                              .toString())
                                          .toString() +
                                      ' per' +
                                      ')',
                                  group: AutoSizeTextGroupItems,
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      )), ///500_owl_tokens
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(_productListTokenAmount[3],
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.green)),
                                  Image.asset(
                                    'assets/img/Owl_Token.png',
                                    width: 40,
                                  ),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(fifteenhundredOwlTokenIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                  _items[fifteenhundredOwlTokenIndex]
                                          .localizedPrice
                                          .toString() +
                                      '(' +
                                      ((double.parse(_items[
                                                          fifteenhundredOwlTokenIndex]
                                                      .price) /
                                                  double.parse(
                                                      _productListTokenAmount[
                                                          3]))
                                              .toStringAsFixed(3))
                                          .toString() +
                                      ' per' +
                                      ')',
                                  group: AutoSizeTextGroupItems,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      )), ///1500_owl_tokens
                  SizedBox(height: 30),
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                children: <Widget>[
                                  AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('extend_radius'),
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(extendradiusIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0.0, left: 0),
                                  child: Row(
                                    children: <Widget>[
                                      AutoSizeText(
                                          _items[extendradiusIndex]
                                              .localizedPrice,
                                          group: AutoSizeTextGroupItems,
                                          style: TextStyle(
                                            fontSize: 23,
                                            color: Colors.white,
                                          )),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )), ///Extend_radius
                  Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 30),
                              child: Row(
                                children: <Widget>[
                                  AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('skip_water_points'),
                                      group: AutoSizeTextGroupItems,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                    icon: ImageIcon(
                                        AssetImage(
                                            'assets/img/double_arrow.png'),
                                        size: 64.0,
                                        color: Colors.white),
                                    onPressed: () {
                                      purchase(skipwaterpointsIndex);
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 50),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0.0, left: 0),
                                  child: Row(
                                    children: <Widget>[
                                      AutoSizeText(
                                          _items[skipwaterpointsIndex]
                                              .localizedPrice,
                                          group: AutoSizeTextGroupItems,
                                          style: TextStyle(
                                            fontSize: 23,
                                            color: Colors.white,
                                          )),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )), ///Skip_water_points
                  SizedBox(height: 30),
                  GoPremiumButton(this.goPremiumButton)
                ],
              ))
        : FadingCircleLoading(
            color: Colors.white,
            size: 75.0,
          ));
  } //Funct

}
