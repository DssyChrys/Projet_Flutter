import 'package:flutter/material.dart';
import 'dart:io';

class PhotoFrame extends StatelessWidget {
  final String? photoPath;
  final int likes;
  final VoidCallback onLike;
  final VoidCallback onTap;
  final VoidCallback onToggleComment; // Ajout du paramètre pour afficher/masquer le champ de commentaire

  const PhotoFrame({
    super.key,
    required this.photoPath,
    required this.likes,
    required this.onLike,
    required this.onTap,
    required this.onToggleComment, // Ajout du paramètre dans le constructeur
  });

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
                  child: const Icon(
                    Icons.add_photo_alternate,
                    size: 50,
                    color: Colors.grey,
                  ),
                )
                    : photoPath!.startsWith('http')
                    ? Image.network(
                  photoPath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
                    : Image.file(
                  File(photoPath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
                    onPressed: onLike, // Appelle la fonction de HomeScreen
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: onToggleComment, // Appelle la fonction pour afficher/masquer le champ de commentaire
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {},
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
