import UIKit
import Flutter
import FirebaseCore

@main
@objc class AppDelegate:
    FlutterAppDelegate,
    FlutterImplicitEngineDelegate {

    private let deviceChannelName =
        "native/device"

    private let performanceChannelName =
        "native/performance"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

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

        GeneratedPluginRegistrant.register(
            with: engineBridge.pluginRegistry
        )

        guard let registrar =
        engineBridge.pluginRegistry.registrar(
            forPlugin: "native_plugin"
        )
        else {
            return
        }

        // Device Channel
        let deviceChannel =
            FlutterMethodChannel(
                name: deviceChannelName,
                binaryMessenger:
                registrar.messenger()
            )

        deviceChannel.setMethodCallHandler {
            (call, result) in

            switch call.method {

            case "getBattery":

                UIDevice.current
                    .isBatteryMonitoringEnabled = true

                let batteryLevel =
                    Int(
                        UIDevice.current
                            .batteryLevel * 100
                    )

                result("\(batteryLevel)%")

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

        // Performance Channel
        let performanceChannel =
            FlutterMethodChannel(
                name: performanceChannelName,
                binaryMessenger:
                registrar.messenger()
            )

        performanceChannel.setMethodCallHandler {
            (call, result) in

            switch call.method {

            case "calculateSum":

                guard let args =
                call.arguments as? [String: Any],
                      let count =
                      args["count"] as? Int
                else {

                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENT",
                            message: "Count not provided",
                            details: nil
                        )
                    )

                    return
                }

                var sum: Int64 = 0

                for i in 1...count {
                    sum += Int64(i)
                }

                result(sum)

            default:

                result(
                    FlutterMethodNotImplemented
                )
            }
        }
    }
}