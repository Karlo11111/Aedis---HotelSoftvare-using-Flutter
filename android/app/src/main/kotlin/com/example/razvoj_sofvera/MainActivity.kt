package com.example.razvoj_sofvera

import android.os.Bundle

import io.flutter.embedding.android.FlutterActivity

import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        
        SplashScreen.show(this, true)
        super.onCreate(savedInstanceState)
    }
}
