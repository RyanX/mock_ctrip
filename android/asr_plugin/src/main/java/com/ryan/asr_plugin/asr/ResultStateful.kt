package com.ryan.asr_plugin.asr

import android.util.Log
import io.flutter.plugin.common.MethodChannel

class ResultStateful(result: MethodChannel.Result) : MethodChannel.Result {

    private val TAG = "ResultStateful"
    private var result: MethodChannel.Result? = null
    private var called: Boolean = false

    companion object {
        fun of(result: MethodChannel.Result): ResultStateful {
            return ResultStateful(result)
        }
    }

    init {
        this.result = result
    }

    override fun success(result: Any?) {
        if (called) {
            printError()
            return
        }
        called = true
        this.result?.success(result)
    }

    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        if (called) {
            printError()
            return
        }
        called = true
        this.result?.error(errorCode, errorMessage, errorDetails)
    }

    override fun notImplemented() {
        if (called) {
            printError()
            return
        }
        called = true
        this.result?.notImplemented()
    }

    private fun printError() {
        Log.e(TAG, "error:result called")
    }
}