import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

final _logger = Logger('ObjectRecognition');

/// Represents a detected object in an image
class DetectedObject {
  final String label;
  final double confidence;
  final Rect boundingBox;

  DetectedObject({
    required this.label,
    required this.confidence,
    required this.boundingBox,
  });

  factory DetectedObject.fromMap(Map<dynamic, dynamic> map) {
    return DetectedObject(
      label: map['label'] as String,
      confidence: map['confidence'] as double,
      boundingBox: Rect.fromLTWH(
        map['left'] as double,
        map['top'] as double,
        map['width'] as double,
        map['height'] as double,
      ),
    );
  }
}

/// Provides object detection and recognition capabilities
class ObjectRecognition {
  static const MethodChannel _channel = 
      MethodChannel('advanced_image_processing_toolkit/object_recognition');

  /// Detects objects in the given image
  static Future<List<DetectedObject>> detectObjects(
    Uint8List imageBytes,
  ) async {
    try {
      final List<dynamic>? result = await _channel.invokeListMethod(
        'detectObjects',
        {'imageBytes': imageBytes},
      );

      if (result == null) return [];

      return result
          .map((dynamic item) => 
              DetectedObject.fromMap(item as Map<dynamic, dynamic>))
          .toList();
    } on PlatformException catch (e) {
      _logger.warning('Failed to detect objects: ${e.message}');
      return [];
    }
  }
} 