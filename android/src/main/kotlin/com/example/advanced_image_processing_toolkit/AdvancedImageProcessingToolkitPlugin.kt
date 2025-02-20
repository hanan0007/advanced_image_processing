package com.example.advanced_image_processing_toolkit

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class AdvancedImageProcessingToolkitPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "advanced_image_processing_toolkit")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "applyGrayscale" -> {
        val imageData = call.argument<ByteArray>("imageData")
        if (imageData != null) {
          // TODO: Implement grayscale conversion
          result.success(imageData)
        } else {
          result.error("INVALID_ARGUMENT", "Image data is required", null)
        }
      }
      "applyBlur" -> {
        val imageData = call.argument<ByteArray>("imageData")
        val sigma = call.argument<Double>("sigma")
        if (imageData != null && sigma != null) {
          // TODO: Implement blur
          result.success(imageData)
        } else {
          result.error("INVALID_ARGUMENT", "Image data and sigma are required", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
} 