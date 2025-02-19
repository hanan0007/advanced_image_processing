import 'package:flutter/material.dart';
import 'package:advanced_image_processing_toolkit/advanced_image_processing_toolkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AdvancedImageProcessingToolkit');

void main() {
  // Initialize logging
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Processing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final _picker = ImagePicker();
  List<DetectedObject>? _detectedObjects;

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _detectedObjects = null;
        });
      }
    } catch (e) {
      _logger.warning('Failed to pick image: $e');
    }
  }

  Future<void> _applyGrayscale() async {
    if (_imageBytes != null) {
      try {
        final processed = await ImageFilters.applyGrayscale(_imageBytes!);
        setState(() {
          _imageBytes = processed;
        });
      } catch (e) {
        _logger.warning('Failed to apply grayscale: $e');
      }
    }
  }

  Future<void> _detectObjects() async {
    if (_imageBytes != null) {
      try {
        final objects = await ObjectRecognition.detectObjects(_imageBytes!);
        setState(() {
          _detectedObjects = objects;
        });
      } catch (e) {
        _logger.warning('Failed to detect objects: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Processing Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageBytes != null) ...[
              Image.memory(
                _imageBytes!,
                height: 300,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _applyGrayscale,
                    child: const Text('Apply Grayscale'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _detectObjects,
                    child: const Text('Detect Objects'),
                  ),
                ],
              ),
            ],
            if (_detectedObjects != null) ...[
              const SizedBox(height: 20),
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
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
