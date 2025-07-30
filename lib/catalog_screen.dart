import 'package:flutter/material.dart';
import 'image_preview_screen.dart';

class CatalogScreen extends StatelessWidget {
  // Genera automáticamente la lista de imágenes desde 12.png hasta 87.png
  final List<String> images = List.generate(
    87 - 12 + 1, // cantidad de imágenes
    (index) => 'assets/${12 + index}.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9DC),
      appBar: AppBar(
        title: const Text('Catálogo'),
        backgroundColor: const Color(0xFF8C4C2F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagePreviewScreen(imagePath: images[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(images[index], fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    );
  }
}
