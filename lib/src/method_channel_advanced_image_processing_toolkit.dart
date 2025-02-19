import 'package:flutter/services.dart';
import 'package:advanced_image_processing_toolkit/src/advanced_image_processing_toolkit_platform_interface.dart';

class MethodChannelAdvancedImageProcessingToolkit extends AdvancedImageProcessingToolkitPlatform {
  final MethodChannel _arChannel = const MethodChannel('advanced_image_processing_toolkit/augmented_reality');
  final MethodChannel _filtersChannel = const MethodChannel('advanced_image_processing_toolkit/filters');

  @override
  Future<bool> isARSupported() async {
    try {
      final bool result = await _arChannel.invokeMethod('isARSupported');
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> startARSession() async {
    try {
      final String result = await _arChannel.invokeMethod('startARSession');
      return result;
    } catch (e) {
      return 'error';
    }
  }

  @override
  Future<String> placeModel(String modelPath, Map<String, double> position) async {
    try {
      final String result = await _arChannel.invokeMethod('placeModel', {
        'modelPath': modelPath,
        'position': position,
      });
      return result;
    } catch (e) {
      return 'error';
    }
  }

  @override
  Future<List<int>> applyGrayscale(List<int> imageData) async {
    try {
      final List<dynamic> result = await _filtersChannel.invokeMethod('applyGrayscale', {
        'imageData': imageData,
      });
      return result.cast<int>();
    } catch (e) {
      return imageData;
    }
  }

  @override
  Future<List<int>> applyBlur(List<int> imageData, double sigma) async {
    try {
      final List<dynamic> result = await _filtersChannel.invokeMethod('applyBlur', {
        'imageData': imageData,
        'sigma': sigma,
      });
      return result.cast<int>();
    } catch (e) {
      return imageData;
    }
  }
} 