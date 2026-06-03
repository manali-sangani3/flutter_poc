//package com.example.step_counter_plugin
//
//import android.content.Context
//import android.hardware.Sensor
//import android.hardware.SensorEvent
//import android.hardware.SensorEventListener
//import android.hardware.SensorManager
//
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.plugin.common.EventChannel
//
//class StepCounterPlugin :
//    FlutterPlugin,
//    EventChannel.StreamHandler,
//    SensorEventListener {
//
//    private lateinit var eventChannel: EventChannel
//    private lateinit var sensorManager: SensorManager
//
//    private var eventSink: EventChannel.EventSink? =
//        null
//
//    override fun onAttachedToEngine(
//        binding: FlutterPlugin.FlutterPluginBinding
//    ) {
//
//        eventChannel =
//            EventChannel(
//                binding.binaryMessenger,
//                "step_counter_plugin/steps"
//            )
//
//        eventChannel.setStreamHandler(this)
//
//        sensorManager =
//            binding.applicationContext
//                .getSystemService(
//                    Context.SENSOR_SERVICE
//                ) as SensorManager
//    }
//
//    override fun onDetachedFromEngine(
//        binding: FlutterPlugin.FlutterPluginBinding
//    ) {
//        eventChannel.setStreamHandler(null)
//    }
//
//    override fun onListen(
//        arguments: Any?,
//        events: EventChannel.EventSink?
//    ) {
//
//        eventSink = events
//
//        val sensor =
//            sensorManager.getDefaultSensor(
//                Sensor.TYPE_STEP_COUNTER
//            )
//
//        sensor?.let {
//            sensorManager.registerListener(
//                this,
//                it,
//                SensorManager.SENSOR_DELAY_NORMAL
//            )
//        }
//    }
//
//    override fun onCancel(arguments: Any?) {
//        sensorManager.unregisterListener(this)
//    }
//
//    override fun onSensorChanged(
//        event: SensorEvent?
//    ) {
//
//        val steps =
//            event?.values?.firstOrNull()?.toInt()
//
//        eventSink?.success(steps)
//    }
//
//    override fun onAccuracyChanged(
//        sensor: Sensor?,
//        accuracy: Int
//    ) {
//    }
//}
package com.example.step_counter_plugin

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

class StepCounterPlugin :
    FlutterPlugin,
    EventChannel.StreamHandler {

    private lateinit var eventChannel: EventChannel

    private var eventSink: EventChannel.EventSink? = null

    private var handler: Handler? = null

    private var runnable: Runnable? = null

    override fun onAttachedToEngine(
        binding: FlutterPlugin.FlutterPluginBinding
    ) {

        eventChannel = EventChannel(
            binding.binaryMessenger,
            "step_counter_plugin/steps"
        )

        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(
        binding: FlutterPlugin.FlutterPluginBinding
    ) {
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(
        arguments: Any?,
        events: EventChannel.EventSink?
    ) {

        eventSink = events

        var steps = 0

        handler = Handler(
            Looper.getMainLooper()
        )

        runnable = object : Runnable {

            override fun run() {

                steps += 5

                eventSink?.success(
                    steps
                )

                handler?.postDelayed(
                    this,
                    1000
                )
            }
        }

        handler?.post(
            runnable!!
        )
    }

    override fun onCancel(
        arguments: Any?
    ) {

        runnable?.let {
            handler?.removeCallbacks(it)
        }

        runnable = null

        handler = null

        eventSink = null
    }
}