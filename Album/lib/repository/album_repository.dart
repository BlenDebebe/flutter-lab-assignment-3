import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/album.dart';
import '../model/photo.dart';

class AlbumRepository {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Optional: Cache entire photo list per album
  final Map<int, List<Photo>> _photoCache = {};

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$_baseUrl/albums'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    if (_photoCache.containsKey(albumId)) {
      return _photoCache[albumId]!;
    }

    final response = await http.get(Uri.parse('$_baseUrl/photos?albumId=$albumId'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      final photos = data.map((e) => Photo.fromJson(e)).toList();
      _photoCache[albumId] = photos;
      return photos;
    } else {
      throw Exception('Failed to load photos for album $albumId');
    }
  }
}
