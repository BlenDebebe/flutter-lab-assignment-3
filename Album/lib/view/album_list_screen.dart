import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_state.dart';
import '../model/photo.dart';
import 'package:go_router/go_router.dart';
import '../blocs/album_event.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE4E6), // baby pink background
      appBar: AppBar(
        title: const Text('Albums'),
        backgroundColor: const Color(0xFFF48FB1), // bolder pink app bar
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.read<AlbumBloc>().add(FetchAlbums()),
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            final albums = state.albums;
            final photos = state.albumPhotos;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                final Photo? photo = photos[album.id];

                return Card(
                  color: const Color(0xFFF48FB1), // bolder pink card background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: photo != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        photo.url,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                      ),
                    )
                        : const Icon(Icons.photo_album),
                    title: Text(
                      album.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: photo != null
                        ? Text(
                      photo.url,
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    )
                        : null,
                    onTap: () => context.pushNamed('album_detail', extra: {
                      'album': album,
                      'photo': photo,
                    }),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
