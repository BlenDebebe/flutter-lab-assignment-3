import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';

class AlbumViewModel {
  final AlbumBloc bloc;

  AlbumViewModel({required this.bloc});

  void fetchAlbums() {
    bloc.add(FetchAlbums());
  }
}
