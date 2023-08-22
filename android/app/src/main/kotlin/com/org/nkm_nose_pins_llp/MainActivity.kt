package com.org.nkm_nose_pins_llp

import android.os.Build
import android.os.Build.VERSION.SDK_INT
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    //data communication method name
    private val getAndroidVersionMethod: String = "getAndroidVersion"
    private val getVersionNameAndVersionCode: String = "getVersionNameAndVersionCode"

    //method channel and default variable initialization
    private val commonMethodChannel: String = "com.org.nkm_nose_pins_llp/common_channel"
    private val resultHandlers = mutableMapOf<String, MethodChannel.Result>()
    private lateinit var methodChannel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, commonMethodChannel
        )
        methodChannel.setMethodCallHandler { call, result ->
            resultHandlers[commonMethodChannel] = result
            when (call.method) {

                getVersionNameAndVersionCode -> {
                    try {
                        val versionName = BuildConfig.VERSION_NAME
                        val versionCode = BuildConfig.VERSION_CODE
                        val packageName = BuildConfig.APPLICATION_ID
                        result.success(
                            mapOf(
                                "version_name" to versionName,
                                "version_code" to versionCode,
                                "package_name" to packageName
                            )
                        );
                    } catch (e: Exception) {
                        result.error(
                            "Error Code: Failed to get Version Name & Code!",
                            e.toString(),
                            "Error Details: Failed to get Version Name and Version Code!"
                        )
                    }
                }

                getAndroidVersionMethod -> {
                    result.success(getAndroidVersion().toString().trim())
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getAndroidVersion(): Int {
        return when (SDK_INT) {
            Build.VERSION_CODES.P -> 9
            Build.VERSION_CODES.Q -> 10
            Build.VERSION_CODES.R -> 11
            Build.VERSION_CODES.S -> 12
            Build.VERSION_CODES.S_V2 -> 12
            Build.VERSION_CODES.TIRAMISU -> 13
            else -> if (SDK_INT >= 33) 100 else -1
        }
    }
}