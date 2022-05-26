package com.ctrip.mock.mock_ctrip

import android.os.Bundle
import com.ryan.asr_plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.flutterEngine?.let { GeneratedPluginRegistrant.registerWith(it) }
    }

    private fun registerSelfPlugin(){
//        AsrPlugin.registerWith(registrarFor("com.wy.plugin.asr.AsrPlugin"))
    }
}
