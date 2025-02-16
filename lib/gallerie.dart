import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final galleryDir = Directory('${directory.path}/Gallery');

    if (galleryDir.existsSync()) {
      setState(() {
        images = galleryDir
            .listSync()
            .whereType<FileSystemEntity>()
            .map((e) => File(e.path))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galerie')),
      body: images.isEmpty
          ? Center(child: Text('Aucune image téléchargée'))
          : GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Image.file(images[index]),
                ),
              );
            },
            child: Image.file(images[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
