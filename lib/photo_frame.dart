import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PhotoFrame extends StatelessWidget {
  final String? photoPath;
  final int likes;
  final VoidCallback onLike;
  final VoidCallback onTap;
  final VoidCallback onToggleComment;

  const PhotoFrame({
    super.key,
    required this.photoPath,
    required this.likes,
    required this.onLike,
    required this.onTap,
    required this.onToggleComment,
  });

  Future<void> _downloadImage(BuildContext context) async {
    if (photoPath == null || !photoPath!.startsWith('http')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Téléchargement impossible')),
      );
      return;
    }

    try {
      // Vérifier et demander la permission
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permission refusée')),
          );
          return;
        }
      }

      // Récupérer le répertoire des documents de l'application et créer le dossier Gallery s'il n'existe pas
      var appDir = await getApplicationDocumentsDirectory();
      var galleryDir = Directory('${appDir.path}/Gallery');

      // Si le dossier "Gallery" n'existe pas, on le crée
      if (!galleryDir.existsSync()) {
        galleryDir.createSync();
      }

      // Nom du fichier et chemin de destination dans le répertoire Gallery
      String fileName = photoPath!.split('/').last;
      String filePath = '${galleryDir.path}/$fileName';

      // Télécharger l'image
      Dio dio = Dio();
      await dio.download(photoPath!, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image téléchargée dans : $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de téléchargement : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: photoPath == null
                    ? Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                )
                    : photoPath!.startsWith('http')
                    ? Image.network(photoPath!, fit: BoxFit.cover, width: double.infinity)
                    : Image.file(File(photoPath!), fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      likes > 0 ? Icons.favorite : Icons.favorite_border,
                      color: likes > 0 ? Colors.red : Colors.black,
                    ),
                    onPressed: onLike,
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: onToggleComment,
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => _downloadImage(context),
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
