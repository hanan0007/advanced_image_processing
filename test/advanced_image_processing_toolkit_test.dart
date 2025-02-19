import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit_platform_interface.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAdvancedImageProcessingToolkitPlatform
    with MockPlatformInterfaceMixin
    implements AdvancedImageProcessingToolkitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AdvancedImageProcessingToolkitPlatform initialPlatform = AdvancedImageProcessingToolkitPlatform.instance;

  test('$MethodChannelAdvancedImageProcessingToolkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAdvancedImageProcessingToolkit>());
  });

  test('getPlatformVersion', () async {
    AdvancedImageProcessingToolkit advancedImageProcessingToolkitPlugin = AdvancedImageProcessingToolkit();
    MockAdvancedImageProcessingToolkitPlatform fakePlatform = MockAdvancedImageProcessingToolkitPlatform();
    AdvancedImageProcessingToolkitPlatform.instance = fakePlatform;

    expect(await advancedImageProcessingToolkitPlugin.getPlatformVersion(), '42');
  });
}
