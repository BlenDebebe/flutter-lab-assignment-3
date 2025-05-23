import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/album.dart';
import '../model/photo.dart';

class AlbumRepository {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Cache for storing one photo per album ID
  final Map<int, Photo> _photoCache = {};

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$_baseUrl/albums'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Photo> fetchPhoto(int albumId) async {
    // Return cached photo if available
    if (_photoCache.containsKey(albumId)) {
      return _photoCache[albumId]!;
    }

    // Otherwise fetch from API
    final response = await http.get(Uri.parse('$_baseUrl/photos?albumId=$albumId&_limit=1'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final photo = Photo.fromJson(data.first);
        _photoCache[albumId] = photo; // Cache it
        return photo;
      } else {
        throw Exception('No photos found for album $albumId');
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
