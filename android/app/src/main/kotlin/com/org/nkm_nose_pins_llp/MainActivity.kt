package com.org.nkm_nose_pins_llp

import android.os.Build
import android.os.Build.VERSION.SDK_INT
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    //data communication method name
    private val getAndroidVersionMethod: String = "getAndroidVersion"

    //method channel and default variable initialization
    private val commonMethodChannel: String = "com.org.nkm_nose_pins_llp/common_channel"
    private val resultHandlers = mutableMapOf<String, MethodChannel.Result>()
    private lateinit var methodChannel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            commonMethodChannel
        )
        methodChannel.setMethodCallHandler { call, result ->
            resultHandlers[commonMethodChannel] = result
            when (call.method) {
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
//
//    fun getVersionCode(context: Context): Long {
//        val packageManager = context.packageManager
//        val packageName = context.packageName
//
//        val packageInfo = PackageManagerCompat.getPackageInfoCompat(packageManager, packageName, 0)
//        return PackageInfoCompat.getLongVersionCode(packageInfo)
//    }
//
//    fun getVersionName(context: Context): String {
//        val packageManager = context.packageManager
//        val packageName = context.packageName
//
//        val packageInfo = PackageManagerCompat.getPackageInfoCompat(packageManager, packageName, 0)
//        return packageInfo.versionName
//    }
//
//    // Usage example
//    val versionCode = getVersionCode(context)
//    val versionName = getVersionName(context)


}