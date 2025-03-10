# Advanced Image Processing Toolkit

<div align="center">

[![Pub Version](https://img.shields.io/pub/v/advanced_image_processing_toolkit)](https://pub.dev/packages/advanced_image_processing_toolkit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev)

A powerful Flutter plugin that provides advanced image processing capabilities, including real-time filters, object recognition, and augmented reality features.

</div>

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
  - [Basic Setup](#basic-setup)
  - [Image Filtering](#image-filtering)
  - [Object Detection](#object-detection)
  - [Augmented Reality](#augmented-reality)
- [API Reference](#api-reference)
- [Platform Support](#platform-support)
- [Future Updates](#future-updates)
- [Requirements](#requirements)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🔍 Overview

Advanced Image Processing Toolkit is a comprehensive Flutter plugin designed to bring sophisticated image processing capabilities to your mobile applications. Whether you need to apply filters to images, detect objects in real-time, or create immersive AR experiences, this toolkit provides a unified, easy-to-use API that works across platforms.

## ✨ Features

### 🎨 Real-time Image Filters
- **Grayscale Conversion**: Transform color images to grayscale with a single function call
- **Gaussian Blur**: Apply configurable blur effects with adjustable intensity
- **Brightness Adjustment**: Easily modify image brightness with precise control
- **Contrast Enhancement**: Improve image contrast for better visibility
- **Custom Filter Support**: Create and apply your own custom filters

### 🔍 Object Detection & Recognition
- **Real-time Object Detection**: Identify objects in images or camera feed
- **Multiple Object Recognition**: Detect and track multiple objects simultaneously
- **Confidence Score Reporting**: Get accuracy metrics for each detection
- **Bounding Box Calculation**: Receive precise object locations within images
- **Custom Model Integration**: Use your own trained models for specialized detection

### 🎮 Augmented Reality
- **3D Model Placement**: Position 3D models in real-world space
- **AR Session Management**: Easily control AR experiences
- **Surface Detection**: Identify and use real-world surfaces
- **Real-world Scale Adjustment**: Ensure proper sizing of virtual objects
- **Interactive AR Elements**: Create engaging user experiences

### 💪 Performance Optimized
- **Hardware Acceleration**: Utilizes GPU for faster processing
- **Memory Efficient**: Optimized for mobile device constraints
- **Battery Conscious**: Designed to minimize power consumption
- **Cross-platform Consistency**: Reliable performance on both iOS and Android

## 📥 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  advanced_image_processing_toolkit: ^0.0.10
```

Then run:

```bash
flutter pub get
```

### Platform-specific Setup

#### Android

Add the following permissions to your `AndroidManifest.xml` file:

```xml
<!-- For image processing and camera access -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

<!-- For AR features -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera.ar" />
```

#### iOS

Add the following to your `Info.plist` file:

```xml
<!-- Camera permissions -->
<key>NSCameraUsageDescription</key>
<string>This app needs camera access for image processing and AR features</string>

<!-- Photo library permissions -->
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to process your images</string>
```

## 🚀 Getting Started

### Basic Setup

First, import the package:

```dart
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';
```

Initialize the toolkit in your app (typically in `main.dart` or during app startup):

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the toolkit
  await AdvancedImageProcessingToolkit.initialize(
    enableObjectDetection: true,
    enableAR: true,
  );
  
  runApp(MyApp());
}
```

### Image Filtering

Apply filters to images with just a few lines of code:

```dart
// Create an instance of ImageFilters
final imageFilters = ImageFilters();

// Apply grayscale filter
Future<void> convertToGrayscale(Uint8List imageBytes) async {
  try {
    // Apply the filter
    final processedImage = await imageFilters.applyGrayscale(imageBytes);
    
    // Use the processed image
    setState(() {
      _displayImage = processedImage;
    });
  } catch (e) {
    print('Error applying grayscale: $e');
  }
}

// Apply blur filter
Future<void> applyBlur(Uint8List imageBytes) async {
  try {
    // Apply blur with sigma value of 5.0
    final processedImage = await imageFilters.applyBlur(imageBytes, 5.0);
    
    // Use the processed image
    setState(() {
      _displayImage = processedImage;
    });
  } catch (e) {
    print('Error applying blur: $e');
  }
}

// Adjust brightness
Future<void> adjustBrightness(Uint8List imageBytes) async {
  try {
    // Increase brightness by 20%
    final processedImage = await ImageFilters.adjustBrightness(imageBytes, 1.2);
    
    // Use the processed image
    setState(() {
      _displayImage = processedImage;
    });
  } catch (e) {
    print('Error adjusting brightness: $e');
  }
}
```

### Object Detection

Detect objects in images:

```dart
Future<void> detectObjectsInImage(Uint8List imageBytes) async {
  try {
    // Perform object detection
    final detections = await ObjectRecognition.detectObjects(imageBytes);
    
    // Process the results
    for (var detection in detections) {
      print('Detected: ${detection.label}');
      print('Confidence: ${detection.confidence}');
      print('Position: ${detection.boundingBox}');
      
      // Draw bounding box or highlight the object
      // ...
    }
  } catch (e) {
    print('Error detecting objects: $e');
  }
}
```

### Augmented Reality

Create AR experiences:

```dart
Future<void> startARExperience() async {
  // Check if AR is supported on the device
  final isSupported = await AugmentedReality.isARSupported();
  
  if (isSupported) {
    // Start an AR session
    final sessionStarted = await AugmentedReality.startARSession();
    
    if (sessionStarted) {
      // Place a 3D model in the AR scene
      await AugmentedReality.placeModel(
        modelPath: 'assets/models/robot.glb',
        position: [0.0, 0.0, -1.0],
        scale: 0.5,
        rotation: [0.0, 45.0, 0.0],
      );
    }
  } else {
    print('AR is not supported on this device');
  }
}

// Stop the AR session when done
Future<void> stopARExperience() async {
  await AugmentedReality.stopARSession();
}
```

## 📚 API Reference

### ImageFilters

| Method | Description | Parameters | Return Type |
|--------|-------------|------------|-------------|
| `applyGrayscale` | Converts an image to grayscale | `List<int> imageData` | `Future<List<int>>` |
| `applyBlur` | Applies Gaussian blur to an image | `List<int> imageData, double sigma` | `Future<List<int>>` |
| `adjustBrightness` | Adjusts image brightness | `Uint8List imageBytes, double factor` | `Future<Uint8List>` |

### ObjectRecognition

| Method | Description | Parameters | Return Type |
|--------|-------------|------------|-------------|
| `detectObjects` | Detects objects in an image | `Uint8List imageBytes` | `Future<List<DetectedObject>>` |

### DetectedObject

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | The name/class of the detected object |
| `confidence` | `double` | Confidence score (0.0 to 1.0) |
| `boundingBox` | `Rect` | Position and size of the object in the image |

### AugmentedReality

| Method | Description | Parameters | Return Type |
|--------|-------------|------------|-------------|
| `isARSupported` | Checks if AR is supported on the device | None | `Future<bool>` |
| `startARSession` | Starts an AR session | None | `Future<bool>` |
| `stopARSession` | Stops the current AR session | None | `Future<bool>` |
| `placeModel` | Places a 3D model in AR space | `String modelPath, List<double> position, double scale, List<double> rotation` | `Future<bool>` |

## 🖥️ Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | 🚧 Coming soon |
| macOS    | 🚧 Coming soon |
| Windows  | 🚧 Coming soon |
| Linux    | 🚧 Coming soon |

## 🔮 Future Updates

We're actively working on enhancing the Advanced Image Processing Toolkit with the following features:

### 🎨 Enhanced Image Filters
- **Sepia Filter**: Add vintage tone to images
- **Vignette Effect**: Create stylish darkened corners
- **Color Manipulation**: HSL adjustments, color inversion, and tinting
- **Artistic Filters**: Watercolor, oil painting, and sketch effects
- **Custom Filter Chains**: Combine multiple filters with configurable parameters

### 🧠 Advanced ML Capabilities
- **Custom ML Model Support**: Import and use your own trained models
- **Specialized Detection Models**: Industry-specific object recognition
- **Face Detection & Analysis**: Facial feature recognition and emotion detection
- **Text Recognition**: OCR capabilities for document scanning
- **Pose Estimation**: Human pose detection and tracking

### 🌟 Enhanced AR Features
- **Occlusion**: Allow virtual objects to be hidden behind real-world objects
- **Lighting Estimation**: Adapt virtual content to match real-world lighting
- **Environment Mapping**: Reflect real-world surroundings on virtual objects
- **Persistent AR**: Save and reload AR experiences
- **Collaborative AR**: Multi-user AR experiences

### 📱 Expanded Platform Support
- **Web Support**: Full functionality in browser environments
- **Desktop Support**: Native performance on Windows, macOS, and Linux
- **Cross-platform Consistency**: Unified API across all platforms

### ⚡ Performance Optimizations
- **Real-time Processing**: Enhanced algorithms for faster processing
- **Memory Usage Reduction**: More efficient resource management
- **Battery Consumption**: Further optimizations for mobile devices
- **Parallel Processing**: Multi-threading support for complex operations

Stay tuned for these exciting updates! Follow our [GitHub repository](https://github.com/emorilebo/advanced_image_processing) for the latest developments.

## 📋 Requirements

- **Flutter SDK**: >=2.12.0
- **Dart**: >=2.12.0
- **iOS**: 11.0 or newer
- **Android**: API level 21 or newer

## 📱 Examples

### Complete Image Processing Example

```dart
import 'package:flutter/material.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ImageProcessingDemo extends StatefulWidget {
  @override
  _ImageProcessingDemoState createState() => _ImageProcessingDemoState();
}

class _ImageProcessingDemoState extends State<ImageProcessingDemo> {
  Uint8List? _imageBytes;
  final _imageFilters = ImageFilters();
  final _picker = ImagePicker();
  List<DetectedObject>? _detectedObjects;
  
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _detectedObjects = null;
      });
    }
  }
  
  Future<void> _applyGrayscale() async {
    if (_imageBytes != null) {
      final processed = await _imageFilters.applyGrayscale(_imageBytes!);
      setState(() {
        _imageBytes = Uint8List.fromList(processed);
      });
    }
  }
  
  Future<void> _detectObjects() async {
    if (_imageBytes != null) {
      final objects = await ObjectRecognition.detectObjects(_imageBytes!);
      setState(() {
        _detectedObjects = objects;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Processing Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageBytes != null) ...[
              Image.memory(
                _imageBytes!,
                height: 300,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _applyGrayscale,
                    child: Text('Apply Grayscale'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _detectObjects,
                    child: Text('Detect Objects'),
                  ),
                ],
              ),
            ],
            if (_detectedObjects != null) ...[
              SizedBox(height: 20),
              Text('Detected ${_detectedObjects!.length} objects'),
              Expanded(
                child: ListView.builder(
                  itemCount: _detectedObjects!.length,
                  itemBuilder: (context, index) {
                    final obj = _detectedObjects![index];
                    return ListTile(
                      title: Text(obj.label),
                      subtitle: Text('Confidence: ${obj.confidence.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
```

## ❓ Troubleshooting

### Common Issues

#### "Method not implemented" error

This usually means you're using a feature that isn't supported on the current platform. Check the platform support table and ensure you're using compatible features.

#### Poor performance with large images

For large images, consider resizing before processing:

```dart
// Example of resizing an image before processing
Future<Uint8List> resizeImage(Uint8List originalImage, int targetWidth) async {
  // Implementation depends on your image processing library
  // ...
}
```

#### AR features not working

Ensure your device supports ARCore (Android) or ARKit (iOS). You can check with:

```dart
bool isSupported = await AugmentedReality.isARSupported();
```

### Getting Help

If you encounter issues not covered here:

1. Check the [GitHub issues](https://github.com/emorilebo/advanced_image_processing/issues) for similar problems
2. Open a new issue with detailed information about your problem
3. Include device information, Flutter version, and steps to reproduce

## 🤝 Contributing

Contributions are always welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Setup

```bash
# Clone the repository
git clone https://github.com/emorilebo/advanced_image_processing.git

# Navigate to the project
cd advanced_image_processing

# Get dependencies
flutter pub get

# Run tests
flutter test

# Run the example app
cd example
flutter run
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Godfrey Lebo**
- GitHub: [@emorilebo](https://github.com/emorilebo)
- Website: [godfreylebo.vercel.app](https://godfreylebo.vercel.app/)

## 🙏 Support

If you find this package helpful, please consider:
- ⭐ Starring the repository on GitHub
- 🐛 Reporting issues you find
- 📖 Contributing to the documentation
- 🤝 Submitting pull requests

For questions and support, please [open an issue](https://github.com/emorilebo/advanced_image_processing/issues) on GitHub.

---

<div align="center">
Made with ❤️ by <a href="https://github.com/emorilebo">Curiosityxploring</a>
</div> 