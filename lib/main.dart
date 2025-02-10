import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'photo_frame.dart';
import 'image_data.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String?> _photos = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initPhotos(); // Charge 16 images au démarrage
  }

  // Fonction pour pré-remplir la galerie avec 16 images
  void _initPhotos() {
    setState(() {
      _photos.addAll(List.generate(12, (_) => ImageData.getRandomImage()));
    });
  }

  void _addPhotoFrame() {
    setState(() {
      _photos.add(ImageData.getRandomImage());
    });
  }

  Future<void> _selectPhoto(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photos[index] = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addPhotoFrame,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return PhotoFrame(
            photoPath: _photos[index],
            onTap: () => _selectPhoto(index),
          );
        },
      ),
    );
  }
}
