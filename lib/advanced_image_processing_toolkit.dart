// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'advanced_image_processing_toolkit_platform_interface.dart';

export 'src/filters.dart';
export 'src/object_recognition.dart';
export 'src/augmented_reality.dart';

/// Main class for the Advanced Image Processing Toolkit
///
/// This toolkit provides comprehensive image processing capabilities including:
/// - Real-time image filters (grayscale, blur, brightness adjustment)
/// - Object detection and recognition
/// - Augmented reality features
///
/// Future updates will include:
/// - Enhanced image filters (sepia, vignette, artistic filters)
/// - Custom ML model support for specialized object detection
/// - Advanced AR capabilities (occlusion, lighting estimation)
/// - Web and desktop platform support
/// - Performance optimizations for real-time processing
class AdvancedImageProcessingToolkit {
  static const String version = '0.0.10';
  
  /// Initializes the toolkit with optional configuration
  ///
  /// [enableObjectDetection] - Whether to initialize object detection capabilities
  /// [enableAR] - Whether to initialize augmented reality capabilities
  ///
  /// Future versions will support additional parameters for:
  /// - Custom ML models
  /// - AR feature configuration
  /// - Performance optimization settings
  static Future<void> initialize({
    bool enableObjectDetection = true,
    bool enableAR = true,
  }) async {
    // Initialize required native components
    // This will be implemented later
  }

  /// Gets the platform version
  ///
  /// This is primarily used for testing platform integration
  Future<String?> getPlatformVersion() {
    return AdvancedImageProcessingToolkitPlatform.instance.getPlatformVersion();
  }
}
