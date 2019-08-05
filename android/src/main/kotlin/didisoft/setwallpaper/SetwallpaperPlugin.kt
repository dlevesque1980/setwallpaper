package didisoft.setwallpaper


import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.coroutines.*
import java.io.BufferedInputStream
import java.io.IOException
import java.io.InputStream
import java.net.URL
import android.content.ContentValues.TAG




class SetwallpaperPlugin(private val registrar: Registrar) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "didisoft.wallpaper")
            channel.setMethodCallHandler(SetwallpaperPlugin(registrar))

        }
    }


    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        when {
            call.method.equals("setsystemwallpaper") -> {
                val url: String = call.argument("url")!!
                return setWallpaper(url, result, true, false)
            }
            call.method.equals("setlockedwallpaper") -> {
                val url: String = call.argument("url")!!
                return setWallpaper(url, result, false, true)
            }
            call.method.equals("setbothwallpaper") -> {
                val url: String = call.argument("url")!!
                return setWallpaper(url, result, true, true)
            }
            else -> result.notImplemented()
        }
    }


    private fun setWallpaper(url: String, result: Result, system: Boolean, lock: Boolean) {
        val wm = WallpaperManager.getInstance(registrar.context())

        try {
                val result = GlobalScope.async {
                    return@async BitmapFactory.decodeStream(URL(url).openConnection().getInputStream())

                }

                runBlocking{
                    val bitmap = result.await()
                    when {
                        system && lock -> wm.setBitmap(bitmap)
                        system && Build.VERSION.SDK_INT >= 24 -> wm.setBitmap(bitmap, null, false, WallpaperManager.FLAG_SYSTEM)
                        lock && Build.VERSION.SDK_INT >= 24 -> wm.setBitmap(bitmap, null, false, WallpaperManager.FLAG_LOCK)
                        else -> wm.setBitmap(bitmap)
                    }
                }

        } catch (e: IOException) {

        }

        result.success("Wallpaper set successfully!");
    }

}
