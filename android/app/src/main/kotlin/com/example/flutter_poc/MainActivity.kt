package com.example.flutter_poc

import android.os.BatteryManager
import android.os.Build
import android.content.Context

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL =
        "native/device"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call,
                                 result ->

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

                else -> {

                    result.notImplemented()
                }
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