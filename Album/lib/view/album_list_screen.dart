import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/album_bloc.dart';
import '../blocs/album_state.dart';
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

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];

                return Card(
                  color: const Color(0xFFF48FB1), // bolder pink card background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      album.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () => context.pushNamed(
                      'album_detail',
                      extra: {
                        'album': album,
                      },
                    ),
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
