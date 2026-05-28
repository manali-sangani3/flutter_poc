import UIKit
import Flutter
import FirebaseCore

@main
@objc class AppDelegate:
    FlutterAppDelegate,
    FlutterImplicitEngineDelegate {

    private let channelName =
        "native/device"

    override func application(
        _ application: UIApplication,

        didFinishLaunchingWithOptions
        launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        /// Firebase Initialization
        FirebaseApp.configure()

        return super.application(
            application,

            didFinishLaunchingWithOptions:
            launchOptions
        )
    }

    func didInitializeImplicitFlutterEngine(
        _ engineBridge:
            FlutterImplicitEngineBridge
    ) {

        /// Register Flutter Plugins
        GeneratedPluginRegistrant
            .register(
                with:
                engineBridge.pluginRegistry
            )

        /// Create Registrar
        let registrar =
            engineBridge
                .pluginRegistry
                .registrar(
                    forPlugin:
                    "native_device_plugin"
                )

        /// Create MethodChannel
        let methodChannel =
            FlutterMethodChannel(
                name: channelName,

                binaryMessenger:
                registrar!.messenger()
            )

        /// Handle Flutter Calls
        methodChannel
            .setMethodCallHandler {
                (
                    call,
                    result
                ) in

                switch call.method {

                case "getBattery":

                    UIDevice.current
                        .isBatteryMonitoringEnabled =
                        true

                    let batteryLevel =
                        Int(
                            UIDevice.current
                                .batteryLevel * 100
                        )

                    result(
                        "\(batteryLevel)%"
                    )

                case "getDeviceInfo":

                    let deviceInfo =
                        "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"

                    result(deviceInfo)

                default:

                    result(
                        FlutterMethodNotImplemented
                    )
                }
            }
    }
}