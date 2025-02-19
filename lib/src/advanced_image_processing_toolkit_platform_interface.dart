import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:advanced_image_processing_toolkit/src/method_channel_advanced_image_processing_toolkit.dart';

abstract class AdvancedImageProcessingToolkitPlatform extends PlatformInterface {
  AdvancedImageProcessingToolkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static AdvancedImageProcessingToolkitPlatform _instance = MethodChannelAdvancedImageProcessingToolkit();

  static AdvancedImageProcessingToolkitPlatform get instance => _instance;

  static set instance(AdvancedImageProcessingToolkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isARSupported() {
    throw UnimplementedError('isARSupported() has not been implemented.');
  }

  Future<String> startARSession() {
    throw UnimplementedError('startARSession() has not been implemented.');
  }

  Future<String> placeModel(String modelPath, Map<String, double> position) {
    throw UnimplementedError('placeModel() has not been implemented.');
  }

  Future<List<int>> applyGrayscale(List<int> imageData) {
    throw UnimplementedError('applyGrayscale() has not been implemented.');
  }

  Future<List<int>> applyBlur(List<int> imageData, double sigma) {
    throw UnimplementedError('applyBlur() has not been implemented.');
  }
} 