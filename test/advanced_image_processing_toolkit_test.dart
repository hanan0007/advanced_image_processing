import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:advanced_image_processing_toolkit/src/advanced_image_processing_toolkit_platform_interface.dart';

class MockAdvancedImageProcessingToolkitPlatform 
    with MockPlatformInterfaceMixin
    implements AdvancedImageProcessingToolkitPlatform {
  
  @override
  Future<bool> isARSupported() async => true;

  @override
  Future<String> startARSession() async => 'started';

  @override
  Future<String> placeModel(String modelPath, Map<String, double> position) async => 'placed';

  @override
  Future<List<int>> applyGrayscale(List<int> imageData) async => List.from(imageData);

  @override
  Future<List<int>> applyBlur(List<int> imageData, double sigma) async => List.from(imageData);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdvancedImageProcessingToolkit', () {
    setUp(() {
      AdvancedImageProcessingToolkitPlatform.instance = MockAdvancedImageProcessingToolkitPlatform();
    });

    test('isARSupported returns device capability', () async {
      expect(await AdvancedImageProcessingToolkitPlatform.instance.isARSupported(), true);
    });

    test('startARSession returns session status', () async {
      expect(await AdvancedImageProcessingToolkitPlatform.instance.startARSession(), 'started');
    });

    test('placeModel returns placement status', () async {
      expect(
        await AdvancedImageProcessingToolkitPlatform.instance.placeModel('test.glb', {'x': 0.0, 'y': 0.0, 'z': 0.0}),
        'placed'
      );
    });

    test('applyGrayscale returns modified image data', () async {
      final testData = List<int>.generate(10, (i) => i);
      final result = await AdvancedImageProcessingToolkitPlatform.instance.applyGrayscale(testData);
      expect(result.length, equals(testData.length));
    });

    test('applyBlur returns modified image data', () async {
      final testData = List<int>.generate(10, (i) => i);
      final result = await AdvancedImageProcessingToolkitPlatform.instance.applyBlur(testData, 1.0);
      expect(result.length, equals(testData.length));
    });
  });
}
