import 'package:go_router/go_router.dart';
import '../model/album.dart';
import '../model/photo.dart';
import '../view/album_detail_screen.dart';
import '../view/album_list_screen.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'album_list',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/detail',
        name: 'album_detail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final Album album = extra?['album'] as Album;
          final Photo? photo = extra?['photo'] as Photo?;

          return AlbumDetailScreen(album: album, photo: photo);
        },
      ),
    ],
  );
}
