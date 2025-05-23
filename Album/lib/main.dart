import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/app_router.dart';
import 'repository/album_repository.dart';
import 'blocs/album_bloc.dart';
import 'blocs/album_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AlbumRepository(),
      child: BlocProvider(
        create: (context) => AlbumBloc(
          repository: context.read<AlbumRepository>(),
        )..add(FetchAlbums()),
        child: MaterialApp.router(
          theme: ThemeData(
            primarySwatch: Colors.pink,
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(fontSize: 16),
            ),
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
