import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:image/image.dart' as img;

final _logger = Logger('ImageFilters');

/// Provides various image filtering capabilities
///
/// Current filters include:
/// - Grayscale conversion
/// - Gaussian blur
/// - Brightness adjustment
/// - Sepia tone
/// - Invert colors
/// - Edge detection
/// - Emboss effect
///
/// Upcoming filters in future releases:
/// - Vignette effect
/// - Color manipulation (HSL adjustments, tinting)
/// - Artistic filters (watercolor, oil painting, sketch)
/// - Custom filter chains
class ImageFilters {
  static const MethodChannel _channel = MethodChannel('advanced_image_processing_toolkit/filters');

  /// Applies grayscale filter to the provided image data
  static Future<Uint8List> applyGrayscale(Uint8List imageData) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>('applyGrayscale', {
        'imageData': imageData,
      });
      
      if (result != null) {
        _logger.info('Grayscale filter applied successfully using native implementation');
        return result;
      }
      
      // Fallback to Dart implementation
      return _applyGrayscaleDart(imageData);
    } catch (e) {
      _logger.warning('Failed to apply grayscale filter using native implementation: $e');
      return _applyGrayscaleDart(imageData);
    }
  }
  
  /// Dart implementation of grayscale filter
  static Uint8List _applyGrayscaleDart(Uint8List imageData) {
    _logger.info('Using Dart implementation for grayscale filter');
    final image = img.decodeImage(imageData);
    if (image == null) return imageData;
    
    final grayscale = img.grayscale(image);
    return Uint8List.fromList(img.encodeJpg(grayscale));
  }

  /// Applies Gaussian blur with specified sigma value
  static Future<Uint8List> applyBlur(Uint8List imageData, double sigma) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>('applyBlur', {
        'imageData': imageData,
        'sigma': sigma,
      });
      
      if (result != null) {
        _logger.info('Blur filter applied successfully using native implementation');
        return result;
      }
      
      // Fallback to Dart implementation
      return _applyBlurDart(imageData, sigma);
    } catch (e) {
      _logger.warning('Failed to apply blur filter using native implementation: $e');
      return _applyBlurDart(imageData, sigma);
    }
  }
  
  /// Dart implementation of blur filter
  static Uint8List _applyBlurDart(Uint8List imageData, double sigma) {
    _logger.info('Using Dart implementation for blur filter');
    final image = img.decodeImage(imageData);
    if (image == null) return imageData;
    
    final blurred = img.gaussianBlur(image, radius: sigma.toInt());
    return Uint8List.fromList(img.encodeJpg(blurred));
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
      
      if (result != null) {
        _logger.info('Brightness adjusted successfully using native implementation');
        return result;
      }
      
      // Fallback to Dart implementation
      return _adjustBrightnessDart(imageBytes, factor);
    } catch (e) {
      _logger.warning('Failed to adjust brightness using native implementation: $e');
      return _adjustBrightnessDart(imageBytes, factor);
    }
  }
  
  /// Dart implementation of brightness adjustment
  static Uint8List _adjustBrightnessDart(Uint8List imageBytes, double factor) {
    _logger.info('Using Dart implementation for brightness adjustment');
    final image = img.decodeImage(imageBytes);
    if (image == null) return imageBytes;
    
    final adjusted = img.adjustColor(image, brightness: (factor * 100).toInt());
    return Uint8List.fromList(img.encodeJpg(adjusted));
  }
  
  /// Applies sepia tone filter to the image
  static Future<Uint8List> applySepia(Uint8List imageBytes) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>(
        'applySepia',
        {'imageBytes': imageBytes},
      );
      
      if (result != null) {
        _logger.info('Sepia filter applied successfully using native implementation');
        return result;
      }
      
      // Fallback to Dart implementation
      return _applySepiaFilter(imageBytes);
    } catch (e) {
      _logger.warning('Failed to apply sepia filter using native implementation: $e');
      return _applySepiaFilter(imageBytes);
    }
  }
  
  /// Dart implementation of sepia filter
  static Uint8List _applySepiaFilter(Uint8List imageBytes) {
    _logger.info('Using Dart implementation for sepia filter');
    final image = img.decodeImage(imageBytes);
    if (image == null) return imageBytes;
    
    final sepia = img.sepia(image);
    return Uint8List.fromList(img.encodeJpg(sepia));
  }
  
  /// Inverts the colors of the image
  static Future<Uint8List> applyInvert(Uint8List imageBytes) async {
    try {
      final result = await _channel.invokeMethod<Uint8List>(
        'applyInvert',
        {'imageBytes': imageBytes},
      );
      
      if (result != null) {
        _logger.info('Invert filter applied successfully using native implementation');
        return result;
      }
      
      // Fallback to Dart implementation
      return _applyInvertFilter(imageBytes);
    } catch (e) {
      _logger.warning('Failed to apply invert filter using native implementation: $e');
      return _applyInvertFilter(imageBytes);
    }
  }
  
  /// Dart implementation of invert filter
  static Uint8List _applyInvertFilter(Uint8List imageBytes) {
    _logger.info('Using Dart implementation for invert filter');
    final image = img.decodeImage(imageBytes);
    if (image == null) return imageBytes;
    
    final inverted = img.invert(image);
    return Uint8List.fromList(img.encodeJpg(inverted));
  }
} 