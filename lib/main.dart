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
      debugShowCheckedModeBanner: false, // Désactive le badge DEBUG
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
  final List<bool> _showCommentField = []; // Ajout pour gérer l'affichage du champ de commentaire

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
      _showCommentField.addAll(List.generate(12, (_) => false)); // Initialisation des états d'affichage
    });
  }

  void _addPhotoFrame() {
    setState(() {
      _photos.add(ImageData.getRandomImage());
      _likes.add(0);
      _comments.add([]);
      _commentControllers.add(TextEditingController());
      _showCommentField.add(false); // Ajout du nouvel élément dans l'état d'affichage
    });
  }

  void _toggleLike(int index) {
    setState(() {
      _likes[index] = _likes[index] > 0 ? 0 : 1; // Toggle like/unlike
    });
  }

  void _toggleCommentField(int index) {
    setState(() {
      _showCommentField[index] = !_showCommentField[index]; // Toggle visibility du champ de commentaire
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
          childAspectRatio: 0.75, // Ajustement pour éviter l'allongement des éléments
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // Photo + Bouton Like
              Expanded(
                child: PhotoFrame(
                  photoPath: _photos[index],
                  likes: _likes[index],
                  onLike: () => _toggleLike(index),
                  onTap: () => _selectPhoto(index),
                  onToggleComment: () => _toggleCommentField(index), // Passer la fonction
                ),
              ),

              // Champ de saisie de commentaire (affiché si _showCommentField est vrai)
              if (_showCommentField[index])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentControllers[index],
                          decoration: const InputDecoration(
                            hintText: 'Ajouter un commentaire...',
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, size: 20),
                        onPressed: () => _addComment(index),
                      ),
                    ],
                  ),
                ),

              // Liste des commentaires (limite de taille)
              if (_comments[index].isNotEmpty)
                SizedBox(
                  height: 50, // Limite de hauteur pour éviter que la liste grandisse trop
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _comments[index].length,
                    itemBuilder: (context, commentIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
                        child: Text(
                          _comments[index][commentIndex],
                          maxLines: 1, // Empêche les commentaires longs d'étirer l'élément
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
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
