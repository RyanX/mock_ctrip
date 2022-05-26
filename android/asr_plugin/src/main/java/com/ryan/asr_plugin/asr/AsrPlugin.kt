package com.ryan.asr_plugin.asr

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.ryan.asr_plugin.asr.ResultStateful.Companion.of
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import java.util.ArrayList

class AsrPlugin private constructor(registrar: Registrar) : MethodCallHandler {
    private val activity: Activity?
    private var resultStateful: ResultStateful? = null
    private var asrManager: AsrManager? = null
    private val onAsrListener: OnAsrListener = object : OnAsrListener {
        override fun onAsrReady() {}
        override fun onAsrBegin() {}
        override fun onAsrEnd() {}
        override fun onAsrPartialResult(results: Array<String>, recogResult: RecogResult) {}
        override fun onAsrOnlineNluResult(nluResult: String) {}
        override fun onAsrFinalResult(results: Array<String>, recogResult: RecogResult) {
            resultStateful?.success(results[0])
        }

        override fun onAsrFinish(recogResult: RecogResult) {}
        override fun onAsrFinishError(
            errorCode: Int,
            subErrorCode: Int,
            descMessage: String,
            recogResult: RecogResult
        ) {
            resultStateful?.error(descMessage, null, null)
        }

        override fun onAsrLongFinish() {}
        override fun onAsrVolume(volumePercent: Int, volume: Int) {}
        override fun onAsrAudio(data: ByteArray, offset: Int, length: Int) {}
        override fun onAsrExit() {}
        override fun onOfflineLoaded() {}
        override fun onOfflineUnLoaded() {}
    }

    companion object {
        private const val TAG = "AsrPlugin1"
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "asr_plugin")
            val instance = AsrPlugin(registrar)
            channel.setMethodCallHandler(instance)
        }
    }

    init {
        activity = registrar.activity()
        initPermission()
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "start" -> {
                resultStateful = of(result)
                start(methodCall, resultStateful!!)
            }
            "stop" -> stop(methodCall, resultStateful)
            "cancel" -> cancel(methodCall, resultStateful)
            else -> result.notImplemented()
        }
    }

    private fun start(methodCall: MethodCall, resultStateful: ResultStateful) {
        if (activity == null) {
            Log.e(TAG, "Ignored start, current activity is empty")
            resultStateful.error("Ignored start, current activity is empty", null, null)
            return
        }
        if (getAsrManager() != null) {
            val arg:Map<String, Any>? = if (methodCall.arguments is Map<*,*>){
                methodCall.arguments as Map<String, Any>
            }else{
                null
            }

            getAsrManager()?.start(arg)
        } else {
            Log.e(TAG, "Ignored start,current AsrManager is null")
            resultStateful.error("Ignored start,current AsrManager is null", null, null)
        }
    }

    private fun stop(methodCall: MethodCall, resultStateful: ResultStateful?) {
        if (asrManager != null) {
            asrManager!!.stop()
            Log.e(TAG, "停止识别")
        }
    }

    private fun cancel(methodCall: MethodCall, resultStateful: ResultStateful?) {
        if (asrManager != null) {
            asrManager!!.cancel()
            Log.e(TAG, "取消识别")
        }
    }

    private fun getAsrManager(): AsrManager? {
        if (asrManager == null) {
            if (activity != null && !activity.isFinishing) {
                asrManager = AsrManager(activity, onAsrListener)
            }
        }
        return asrManager
    }

    private fun initPermission() {
        val permissions = arrayOf(
            Manifest.permission.RECORD_AUDIO,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.INTERNET,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        )
        val toApplyList = ArrayList<String>()
        for (perm in permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(
                    activity!!, perm
                )
            ) {
                toApplyList.add(perm)
                //进入到这里代表没有权限.
            }
        }
        val tmpList = arrayOfNulls<String>(toApplyList.size)
        if (toApplyList.isNotEmpty()) {
            ActivityCompat.requestPermissions(activity!!, toApplyList.toArray(tmpList), 123)
        }
    }
}