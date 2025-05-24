import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_event.dart';
import 'album_state.dart';
import '../repository/album_repository.dart';
import '../model/photo.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc({required this.repository}) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();

        final Map<int, List<Photo>> albumPhotosMap = {};

        for (final album in albums) {
          final photos = await repository.fetchPhotos(album.id); // fetches multiple photos per album
          albumPhotosMap[album.id] = photos;
        }

        emit(AlbumLoaded(albums: albums, albumPhotos: albumPhotosMap));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
