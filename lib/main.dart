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
  final List<int> _likes = [];
  final List<List<String>> _comments = [];
  final List<TextEditingController> _commentControllers = [];

  @override
  void initState() {
    super.initState();
    _initPhotos(); // Charge 16 images au démarrage
  }

  // Fonction pour pré-remplir la galerie avec 16 images
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


  //Fonction pour gérer les likes;
  void _likePhoto(int index) {
    setState(() {
      _likes[index]++;
    });
  }


  //Fonction pour gérer les commentaires;
  void _addComment(int index, String comment) {
    if (comment.trim().isNotEmpty) {
      setState(() {
        _comments[index].add(comment.trim());
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
          return PhotoFrame(
            photoPath: _photos[index],
            onTap: () => _selectPhoto(index),
          );
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
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _likePhoto(index),
                  ),
                  Text("${_likes[index]} likes"),
                ],
              ),
              TextField(
                controller: _commentControllers[index],
                decoration: InputDecoration(
                  hintText: "Ajouter un commentaire...",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (text){
                  _addComment(index, text);
                  _commentControllers[index].clear();
                }

              ),
              Expanded( //  pour afficher les commentaires
              child: ListView.builder(
                shrinkWrap: true, // Permet d'éviter un problème de hauteur infinie
                physics: NeverScrollableScrollPhysics(), // Désactive le scroll interne
                itemCount: _comments[index].length,
                itemBuilder: (context, commentIndex) {
                return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                _comments[index][commentIndex],
                style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                );
                },
              ),
              ),
              Column(
                children: _comments[index].map((comment) => Text(comment)).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
