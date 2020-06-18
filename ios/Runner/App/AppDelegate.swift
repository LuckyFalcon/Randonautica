import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var mainCoordinator: AppCoordinator?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    
    // for loading TrueEntropy view (soliax) (https://medium.com/@cosinus84/flutter-view-controller-used-in-ios-app-using-coordinator-pattern-8896339d64ba)
            let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
                    
            GeneratedPluginRegistrant.register(with: self)
            GMSServices.provideAPIKey("AIzaSyCjthUQUWhEsIF6ZS86MPaTPfFlqBOccxI")

            // for loading TrueEntropy view (soliax) (https://medium.com/@cosinus84/flutter-view-controller-used-in-ios-app-using-coordinator-pattern-8896339d64ba)
            let navigationController = UINavigationController(rootViewController: flutterViewController)
            navigationController.isNavigationBarHidden = true
            window?.rootViewController = navigationController
            mainCoordinator = AppCoordinator(navigationController: navigationController)
            window?.makeKeyAndVisible()
            
            // channel for flutter to call (TrueEntropy)
            let channel = FlutterMethodChannel(name: "com.randonautica.app", binaryMessenger: flutterViewController.binaryMessenger)
            channel.setMethodCallHandler({(call: FlutterMethodCall, result:   FlutterResult) -> Void in
                guard call.method == "goToTrueEntropy" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                self.mainCoordinator?.start()
                let bytesNeeded = call.arguments as! Int
                self.mainCoordinator?.navigateToTrueEntropyViewController(bytesNeeded: bytesNeeded, rngType: call.method, channel: channel)
            })
            
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
