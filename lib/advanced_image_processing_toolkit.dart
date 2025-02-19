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
class AdvancedImageProcessingToolkit {
  static const String version = '0.0.1';
  
  /// Initializes the toolkit with optional configuration
  static Future<void> initialize({
    bool enableObjectDetection = true,
    bool enableAR = true,
  }) async {
    // Initialize required native components
    // This will be implemented later
  }

  Future<String?> getPlatformVersion() {
    return AdvancedImageProcessingToolkitPlatform.instance.getPlatformVersion();
  }
}
