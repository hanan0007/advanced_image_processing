import 'dart:async';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

final _logger = Logger('ImageFilters');

/// Provides various image filtering capabilities
class ImageFilters {
  static const MethodChannel _channel = MethodChannel('advanced_image_processing_toolkit/filters');

  /// Applies grayscale filter to the provided image data
  Future<List<int>> applyGrayscale(List<int> imageData) async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('applyGrayscale', {
        'imageData': imageData,
      });
      _logger.info('Grayscale filter applied successfully');
      return result.cast<int>();
    } catch (e) {
      _logger.warning('Failed to apply grayscale filter: $e');
      return imageData;
    }
  }

  /// Applies Gaussian blur with specified sigma value
  Future<List<int>> applyBlur(List<int> imageData, double sigma) async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('applyBlur', {
        'imageData': imageData,
        'sigma': sigma,
      });
      _logger.info('Blur filter applied successfully with sigma: $sigma');
      return result.cast<int>();
    } catch (e) {
      _logger.warning('Failed to apply blur filter: $e');
      return imageData;
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
      _logger.warning('Failed to adjust brightness: ${e.message}');
      return imageBytes;
    }
  }
} 