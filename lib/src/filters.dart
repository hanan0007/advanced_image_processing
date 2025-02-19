import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

/// Provides various image filtering capabilities
class ImageFilters {
  static const MethodChannel _channel = MethodChannel('advanced_image_processing_toolkit/filters');

  /// Applies a grayscale filter to the given image
  static Future<Uint8List> applyGrayscale(Uint8List imageBytes) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>(
        'applyGrayscale',
        {'imageBytes': imageBytes},
      );
      return result ?? imageBytes;
    } on PlatformException catch (e) {
      print('Failed to apply grayscale filter: ${e.message}');
      return imageBytes;
    }
  }

  /// Applies a blur filter with the specified radius
  static Future<Uint8List> applyBlur(Uint8List imageBytes, double radius) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>(
        'applyBlur',
        {
          'imageBytes': imageBytes,
          'radius': radius,
        },
      );
      return result ?? imageBytes;
    } on PlatformException catch (e) {
      print('Failed to apply blur filter: ${e.message}');
      return imageBytes;
    }
  }

  /// Adjusts the brightness of the image
  static Future<Uint8List> adjustBrightness(
    Uint8List imageBytes,
    double factor,
  ) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>(
        'adjustBrightness',
        {
          'imageBytes': imageBytes,
          'factor': factor,
        },
      );
      return result ?? imageBytes;
    } on PlatformException catch (e) {
      print('Failed to adjust brightness: ${e.message}');
      return imageBytes;
    }
  }
} 