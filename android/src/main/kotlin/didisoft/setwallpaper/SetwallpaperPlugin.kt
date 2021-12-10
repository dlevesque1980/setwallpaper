package didisoft.setwallpaper


import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.os.Build

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context

import kotlinx.coroutines.*
import java.io.IOException
import java.net.URL

class SetwallpaperPlugin() : FlutterPlugin, MethodCallHandler {

    private lateinit var channel : MethodChannel
    private lateinit var context : Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "didisoft.wallpaper")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        var scope = CoroutineScope(Dispatchers.Main)
        var url: String? = null
        var locked: Boolean = false
        var system: Boolean = false
        when {

            call.method == "setsystemwallpaper" || call.method == "setlockedwallpaper" || call.method == "setbothwallpaper"  -> {
                url = call.argument("url")!!
                system = call.argument("system")!!
                locked = call.argument("locked")!!

                scope.launch {
                    val wallSet = setWallpaper(url, system, locked)
                    when{
                        wallSet -> result.success("Wallpaper set successfully!")
                        else -> result.error("An error occur setting wallpaper...",null,null)
                    }
                }
            }

            else -> return result.notImplemented()
        }


    }


    private suspend fun setWallpaper(url: String, system: Boolean, lock: Boolean): Boolean = coroutineScope {
        val wm = WallpaperManager.getInstance(context)

        try {

            val result = async(Dispatchers.IO) {
                return@async BitmapFactory.decodeStream(URL(url).openConnection().getInputStream())
            }

            when {
                system && lock && Build.VERSION.SDK_INT >= 24 -> wm.setBitmap(result.await(), null, false, WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK)
                system && !lock && Build.VERSION.SDK_INT >= 24 -> wm.setBitmap(result.await(), null, false, WallpaperManager.FLAG_SYSTEM)
                lock && !system && Build.VERSION.SDK_INT >= 24 -> wm.setBitmap(result.await(), null, false, WallpaperManager.FLAG_LOCK)
                else -> wm.setBitmap(result.await())
            }

        } catch (e: IOException) {
            e.printStackTrace()
            return@coroutineScope false
            //result.error("An error occur setting the wallpaper...", null, null)
        }

        return@coroutineScope true
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}
