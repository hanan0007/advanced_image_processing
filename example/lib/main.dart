import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';
import 'package:advanced_image_processing_toolkit/src/filters.dart';
import 'package:advanced_image_processing_toolkit/src/object_recognition.dart';
import 'package:image/image.dart' as img;

final _logger = Logger('AdvancedImageProcessingToolkit');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Request permissions
  await Permission.camera.request();
  await Permission.photos.request();
  await Permission.storage.request();
  
  // Initialize logging
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  
  // Initialize the toolkit
  await AdvancedImageProcessingToolkit.initialize(
    enableObjectDetection: true,
    enableAR: false, // Disable AR for now to avoid dependency issues
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Image Processing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _imageBytes;
  File? _processedImageFile;
  final _picker = ImagePicker();
  List<DetectedObject>? _detectedObjects;
  bool _isProcessing = false;
  String _processingMethod = '';

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _processedImageFile = null;
          _detectedObjects = null;
        });
      }
    } catch (e) {
      _logger.warning('Failed to pick image: $e');
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _processedImageFile = null;
          _detectedObjects = null;
        });
      }
    } catch (e) {
      _logger.warning('Failed to take photo: $e');
      _showError('Failed to take photo: $e');
    }
  }

  Future<void> _processImage(String method) async {
    if (_imageBytes == null) return;

    setState(() {
      _isProcessing = true;
      _processingMethod = method;
    });

    try {
      final tempDir = await getTemporaryDirectory();
      final outputPath = '${tempDir.path}/processed_image.jpg';
      Uint8List processedBytes;
      
      switch (method) {
        case 'grayscale':
          final image = img.decodeImage(_imageBytes!);
          if (image == null) throw Exception('Could not decode image');
          final grayscaled = img.grayscale(image);
          processedBytes = Uint8List.fromList(img.encodeJpg(grayscaled));
          break;
        case 'blur':
          final image = img.decodeImage(_imageBytes!);
          if (image == null) throw Exception('Could not decode image');
          final blurred = img.gaussianBlur(image, radius: 5);
          processedBytes = Uint8List.fromList(img.encodeJpg(blurred));
          break;
        case 'brightness_increase':
          processedBytes = await ImageFilters.adjustBrightness(_imageBytes!, 0.5);
          break;
        case 'brightness_decrease':
          processedBytes = await ImageFilters.adjustBrightness(_imageBytes!, -0.5);
          break;
        case 'object_detection':
          final detections = await ObjectRecognition.detectObjects(_imageBytes!);
          setState(() {
            _detectedObjects = detections;
          });
          processedBytes = _imageBytes!; // For now, just use the original image
          break;
        default:
          processedBytes = _imageBytes!;
      }
      
      // Save the processed image to a file
      await File(outputPath).writeAsBytes(processedBytes);
      
      setState(() {
        _processedImageFile = File(outputPath);
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showError('Error processing image: $e');
    }
  }
  
  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Image Processing Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Advanced Image Processing Toolkit v${AdvancedImageProcessingToolkit.version}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Pick Image'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_imageBytes != null) ...[
                const Text('Original Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Image.memory(
                  _imageBytes!,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                _buildProcessingOptions(),
                const SizedBox(height: 20),
                if (_isProcessing) ...[
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 10),
                  Text('Processing with $_processingMethod...', textAlign: TextAlign.center),
                ] else if (_processedImageFile != null) ...[
                  const Text('Processed Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Image.file(
                    _processedImageFile!,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
                if (_detectedObjects != null && _detectedObjects!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text('Detected Objects', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      itemCount: _detectedObjects!.length,
                      itemBuilder: (context, index) {
                        final obj = _detectedObjects![index];
                        return ListTile(
                          dense: true,
                          title: Text(obj.label),
                          subtitle: Text('Confidence: ${(obj.confidence * 100).toStringAsFixed(2)}%'),
                        );
                      },
                    ),
                  ),
                ],
              ] else ...[
                const SizedBox(height: 100),
                const Center(
                  child: Column(
                    children: [
                      Icon(Icons.image, size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Text('No image selected. Please pick an image or take a photo.'),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Processing Options', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildProcessingButton('Grayscale', 'grayscale'),
            _buildProcessingButton('Blur', 'blur'),
            _buildProcessingButton('Brightness +', 'brightness_increase'),
            _buildProcessingButton('Brightness -', 'brightness_decrease'),
            _buildProcessingButton('Object Detection', 'object_detection'),
          ],
        ),
      ],
    );
  }

  Widget _buildProcessingButton(String label, String method) {
    return ElevatedButton(
      onPressed: () => _processImage(method),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(label),
    );
  }
}
