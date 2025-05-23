import 'package:flutter/material.dart';
import '../model/album.dart';
import '../model/photo.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;
  final Photo? photo;

  const AlbumDetailScreen({super.key, required this.album, this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE4E6), // baby pink
      appBar: AppBar(
        title: const Text('Album Detail '),
        backgroundColor: const Color(0xFFF48FB1), // bolder pink
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFFF48FB1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (photo != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      photo!.url,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50, color: Colors.white),
                    ),
                  )
                else
                  const SizedBox(
                    height: 160,
                    child: Center(
                      child: Text(
                        'No photo available',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  'Album ID: ${album.id}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  album.title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (photo != null) ...[
                  const SizedBox(height: 8),
                  SelectableText(
                    photo!.url,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
