import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'photo_frame.dart';
import 'image_data.dart';

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
  final List<int> _likes = [];
  final List<List<String>> _comments = [];
  final List<TextEditingController> _commentControllers = [];
  
  @override
  void initState() {
    super.initState();
    _initPhotos();
  }

  void _initPhotos() {
    setState(() {
      _photos.addAll(List.generate(12, (_) => ImageData.getRandomImage()));
      _likes.addAll(List.generate(12, (_) => 0));
      _comments.addAll(List.generate(12, (_) => []));
      _commentControllers.addAll(List.generate(12, (_) => TextEditingController()));
    });
  }

  void _addPhotoFrame() {
    setState(() {
      _photos.add(ImageData.getRandomImage());
      _likes.add(0);
      _comments.add([]);
      _commentControllers.add(TextEditingController());
    });
  }

  void _likePhoto(int index) {
    setState(() {
      _likes[index]++;
    });
  }

  void _addComment(int index) {
    String comment = _commentControllers[index].text.trim();
    if (comment.isNotEmpty) {
      setState(() {
        _comments[index].add(comment);
        _commentControllers[index].clear();
      });
    }
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
          return Column(
            children: [
              Expanded(
                child: PhotoFrame(
                  photoPath: _photos[index],
                  onTap: () => _selectPhoto(index),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _likePhoto(index),
                  ),
                  Text('${_likes[index]} Likes'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentControllers[index],
                      decoration: const InputDecoration(
                        hintText: 'Ajouter un commentaire...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _addComment(index),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _comments[index].length,
                  itemBuilder: (context, commentIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(_comments[index][commentIndex]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}