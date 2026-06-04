package com.example.flutter_poc

import android.os.BatteryManager
import android.os.Build
import android.content.Context
import io.flutter.embedding.android.FlutterFragmentActivity

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private val DEVICE_CHANNEL =
        "native/device"

    private val PERFORMANCE_CHANNEL =
        "native/performance"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        // Device Channel
        MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            DEVICE_CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "getBattery" -> {

                    val batteryLevel =
                        getBatteryLevel()

                    result.success(
                        "$batteryLevel%"
                    )
                }

                "getDeviceInfo" -> {

                    val device =
                        "${Build.MANUFACTURER} ${Build.MODEL}"

                    result.success(
                        device
                    )
                }

                else -> result.notImplemented()
            }
        }

        // Performance Channel
        MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            PERFORMANCE_CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "calculateSum" -> {

                    val count =
                        call.argument<Int>(
                            "count"
                        ) ?: 0

                    var sum = 0L

                    for (i in 1..count) {
                        sum += i
                    }

                    result.success(sum)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {

        val batteryManager =
            getSystemService(
                Context.BATTERY_SERVICE
            ) as BatteryManager

        return batteryManager
            .getIntProperty(
                BatteryManager
                    .BATTERY_PROPERTY_CAPACITY
            )
    }
}