import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AugmentedReality', () {
    test('startARSession returns session status', () async {
      final result = await AugmentedReality.startARSession();
      expect(result, isA<bool>());
    });

    test('placeModel returns placement status', () async {
      final result = await AugmentedReality.placeModel(
        modelPath: 'assets/models/cube.glb',
        position: [0.0, 0.0, -2.0],
      );
      expect(result, isA<bool>());
    });

    test('isARSupported returns device capability', () async {
      final result = await AugmentedReality.isARSupported();
      expect(result, isA<bool>());
    });
  });
} 