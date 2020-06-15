import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:toast/toast.dart';

// camrng
import 'package:flutter/services.dart';

import 'addons_shop.dart';

final String piMapsPack = 'fatumbot.addons.nc.maps_pack.v2';
final String piSkipWaterPack = 'fatumbot.addons.nc.skip_water_pack.v2';
final String piEverythingPack = 'fatumbot.addons.nc.maps_skip_water_packs.v2';

class BotWebView extends StatelessWidget {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController webView;

  //
  // camrng
  //
  static const platform = const MethodChannel('com.randonautica.app');
  // flutter->ios(swift) (used to load the TrueEntropy Camera RNG view controller)
  Future<void> _navToCamRNG(int bytesNeeded) async {
    try {
      await platform.invokeMethod('goToTrueEntropy', bytesNeeded);
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }

  //
  // temporal rng
  //
  // flutter->ios(swift) (used to load the TrueEntropy Temporal RNG)
  Future<void> _navToTemporal(int bytesNeeded) async {
    try {
      await platform.invokeMethod('goToTemporal', bytesNeeded);
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }

  //
  // Add-ons shop
  //
  // C# Fatumbot -> javascript/html webbot client front end -> javascript/flutter bridge -> flutter native IAP screen
  Future<void> _navToShop(BuildContext context, String userId) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddonsShop(_available, products, purchases, userId))
    );

    if (result != null && result != '') {
      // flutter->javascript (send to bot the in-app purchase details)
      var json = _purchaseDetails2Json(result);
      var eval = "sendIAPToBot('" + json + "');";
      webView.evaluateJavascript(eval);
      Toast.show("Enabling feature...",
          context,
          duration: Toast.LENGTH_LONG,
          gravity:  Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 88, 136, 226)
      );
    }
  }

  // ios(swift)->flutter (used as a callback so we are given the GID of entropy generated and uploaded to the libwrapper)
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch(call.method) {
      case "gid":
        debugPrint(call.arguments);
        // flutter->javascript (send to bot the gid)
        webView.evaluateJavascript('sendGidToBot("${call.arguments}");');
        return new Future.value("");
    }
  }

  _launchURL(String url) async {
    await launch(url);
  }

  _openMap(String url) async {
    var isStreetView = false;
    var isChain = false;
    var coords = url;
    if (url.contains("map_action=pano")) { // Street View URL
      isStreetView = true;
      coords = coords.replaceAll(
          "https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=", "")
          .replaceAll("&fov=90&heading=235&pitch=10", "");
    } else if (url.contains("maps/dir")) { // Multiple points route
      // Get all points' coordinates from the URL
      isChain = true;
      coords = url.replaceAll("https://www.google.com/maps/dir/", "").replaceAll("+", ",").replaceAll("/", "+to:");
    } else { // Normal Maps URL
      coords = coords.replaceAll("https://www.google.com/maps/place/", "").replaceAll("+", ",");
      coords = coords.substring(0, coords.indexOf("@")-1);
    }

    var googleMapsUrl = url.replaceAll("https://", "comgooglemaps://");
    if (await canLaunch(googleMapsUrl)) {
      // Open in Google Maps
      if (isStreetView) {
        await launch("comgooglemaps://?center=" + coords + "&mapmode=streetview");
      } else if (isChain) { // Multiple points (using the Chains feature)
        var route = "comgooglemaps://?daddr=${coords}&directionsmode=driving".replaceAll("+to:&", "&");
        await launch(route);
      } else { // Normal map view for a point
        await launch("comgooglemaps://?q=${coords}&center=${coords}&zoom=14&mapmode=standard");
      }
    } else {
      if (isStreetView) {
        await launch(url); // Street View in Webview
      } else {
        // Fall back to Apple Maps by extracting our lat/long from the URL
        await launch("http://maps.apple.com/?daddr=" + coords);
      }
    }
  }

  _openSpotify(String url) async {
    var spotifyAppUrl = url.replaceAll("https://open.spotify.com/", "spotify://");
    if (await canLaunch(spotifyAppUrl)) {
      // Open in Spotify app
      await launch(spotifyAppUrl);
    } else {
      // Spotify online
      await launch(url);
    }
  }

  _openTwitter(String url) async {
    var twitterAppUrl = url.replaceAll("https://twitter.com/intent/tweet?text=", "twitter://post?message=");
    if (await canLaunch(twitterAppUrl)) {
      // Open in Twitter app
      await launch(twitterAppUrl);
    } else {
      // Twitter online
      await launch(url);
    }
  }

  _initOneSignal() async {
    OneSignal.shared.init(
        "da21a078-babf-4e22-a032-0ea22de561a7",
        iOSSettings: {
          OSiOSSettings.autoPrompt: true,
          OSiOSSettings.inAppLaunchUrl: true
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    webView.evaluateJavascript('sendPushIdToBot("${status.subscriptionStatus.userId}");');
  }

  _initLocationPermissions() async {
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    print("location permission granted? ${geolocationStatus.value}");
  }

  ///
  /// In-app purchase stuff >>>
  /// https://fireship.io/lessons/flutter-inapp-purchases/
  ///

  /// Fatumbot User ID
  String userID = "";

  /// Is the API available on the device
  bool _available = false;

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> products = [];

  /// Past purchases
  List<PurchaseDetails> purchases = [];

  /// Updates to purchases
  StreamSubscription _subscription;

  /// Get all products available for sale
  void _getProducts() async {
    Set<String> ids = Set.from([piMapsPack, piSkipWaterPack, piEverythingPack]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    products = response.productDetails;
    products.sort((a, b) => a.price.compareTo(b.price));;
  }

  /// Gets past purchases
  void _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      print("[IAP] Past purchase: " + purchase.productID + " => status is: " + purchase.status.toString());
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase, developerPayload: userID);
      }
    }

    purchases = response.pastPurchases;
  }

  void _enablePurchase(PurchaseDetails purchase) {
    print("[IAP] Verifying purchase of " + purchase.productID);
    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      // flutter->javascript (send to bot the in-app purchase details)
      var json = _purchaseDetails2Json(purchase);
      var eval = "sendIAPToBot('" + json + "');";
      webView.evaluateJavascript(eval);
      Toast.show("Thank you. Enabling now...",
          context,
          duration: Toast.LENGTH_LONG,
          gravity:  Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 88, 136, 226)
      );
    }
  }

  String _purchaseDetails2Json(PurchaseDetails purchaseDetails) {
    return '{' +
        '"purchaseID":"' +             purchaseDetails.purchaseID + '",' +
        '"productID":"' +              purchaseDetails.productID + '",' +
        '"localVerificationData":"' +  purchaseDetails.verificationData.localVerificationData + '",' +
        '"serverVerificationData":"' + purchaseDetails.verificationData.serverVerificationData + '",' +
        '"source":"' +                 purchaseDetails.verificationData.source.toString() + '",' +
        '"transactionDate":"' +        purchaseDetails.transactionDate + '",' +
//            '"skPaymentTransaction":"' +   purchaseDetails.skPaymentTransaction + '",' +
//            '"billingClientPurchase":"' +  purchaseDetails.billingClientPurchase. + '",' +
        '"status":"' +                 purchaseDetails.status.toString() + '"' +
        '}';
  }

  _initIAP() async {
    // Check availability of In App Purchases
    _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      // Listen to new purchases
      _subscription = _iap.purchaseUpdatedStream.listen((purchaseDetailsList) {
        for (PurchaseDetails purchase in purchaseDetailsList) {
          print('[IAP] New purchase: ' + purchase.productID);
          _iap.completePurchase(purchase);
          _enablePurchase(purchase);
        }
        purchases.addAll(purchaseDetailsList);
      }, onDone: () {
        print("[IAP] onDone");
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
        print("[IAP] error: " + error);
        Toast.show("Purchase error: " + error,
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity:  Toast.BOTTOM,
                    textColor: Colors.red[600],
                    backgroundColor: Colors.black
        );
      });
    }
  }

  ///
  /// <<< In-app purchase stuff
  ///

  BuildContext context;

  BotWebView();

  @override
  Widget build(BuildContext context) {
    this.context = context;

    var botUrl = "";
    if (Platform.isAndroid) {
      botUrl = "https://devbot.randonauts.com/devbot.html?src=android";

      _initLocationPermissions();
    } else if (Platform.isIOS) {
      botUrl = "https://bot.randonauts.com/index.html?src=ios";
    }

    _initIAP();

    platform.setMethodCallHandler(_handleMethod); // for handling javascript->flutter callbacks
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Randonautica"),
//        ),
        body: WebView(
            initialUrl: botUrl,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'flutterChannel_loadCamRNGWithBytesNeeded',
                  onMessageReceived: (JavascriptMessage message) {
                    _navToCamRNG(int.parse(message.message)); // open swift TrueEntropy Camera RNG view
                  }),
              JavascriptChannel(
                  name: 'flutterChannel_loadTemporalWithBytesNeeded',
                  onMessageReceived: (JavascriptMessage message) {
                    _navToTemporal(int.parse(message.message)); // open swift TrueEntropy Temporal RNG view
                  }),
              JavascriptChannel(
                  name: 'flutterChannel_loadNativeShop',
                  onMessageReceived: (JavascriptMessage message) {
                    userID = message.message;
                    _navToShop(context, message.message); // open Flutter in-app purchase shop
                  }),
              // we can have more than one channels
            ]),
            onWebViewCreated: (WebViewController webViewController) {
              webView = webViewController;
              _controller.complete(webViewController);
            },
            onPageFinished: (String page) {
              if (page.contains("index.html")){
                _initOneSignal();
              }
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("https://www.google.com/maps/place/") ||
                  request.url.startsWith("https://www.google.com/maps/dir/") ||
                  request.url.startsWith("https://www.google.com/maps/@?api=1") ||
                  request.url.startsWith("https://open.spotify.com/") ||
                  request.url.startsWith("https://twitter.com")
              ) {
                if (request.url.startsWith("https://www.google.com/maps")) {
                  _openMap(request.url);
                  return NavigationDecision.prevent;
                }

                if (request.url.startsWith("https://open.spotify.com/")) {
                  _openSpotify(request.url);
                  return NavigationDecision.prevent;
                }

                if (request.url.startsWith("https://twitter.com")) {
                  _openTwitter(request.url);
                  return NavigationDecision.prevent;
                }

                _launchURL(request.url);
                return NavigationDecision.prevent;
              } else if (!request.url.startsWith(botUrl)) {
                _launchURL(request.url);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            }
        ));
  }
}
