package com.randonautica.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Intent

import androidx.annotation.NonNull

import com.randonautica.app.camrng.CamRNGActivity;

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.randonautica.app"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method.equals("gotoCameraRNG")) {
                gotoCameraRNG()
            }
        }
    }

    private fun gotoCameraRNG() {
        val intent = Intent(this, CamRNGActivity::class.java)
        startActivity(intent)
    }
}
